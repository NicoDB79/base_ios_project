//
//  AsyncLocationStream.swift
//  BaseProject
//
//  Created by Nicola De Bei on 07/02/25.
//

import Foundation
import CoreLocation
import Combine

@MainActor
class AsyncLocationStream: NSObject, @MainActor CLLocationManagerDelegate {
    var continuations: [UUID: AsyncThrowingStream<CLLocation, Error>.Continuation] = [:]
    
    let locationManager = CLLocationManager()

    // Only for Combine Solution
    private var listeners = MulticastDelegate<AsyncLocationStreamListener>()
    
    override init() {
        super.init()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func addListener(_ listener: AsyncLocationStreamListener) {
        listeners.add(delegate: listener)
    }
    
    func removeListener(_ listener: AsyncLocationStreamListener) {
        listeners.remove(delegate: listener)
    }
    
    func startLocationUpdates() {
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func stopLocationUpdates() {
        self.locationManager.stopUpdatingLocation()
        continuations.values.forEach {
            $0.finish()
        }
    }
    
    // For AsyncStream solution
    func observeLocationUpdates() -> AsyncThrowingStream<CLLocation, Error> {
        let id = UUID()
        // Create the stream and insert the continuation without capturing self in the @Sendable closure
        var createdContinuation: AsyncThrowingStream<CLLocation, Error>.Continuation!
        let stream = AsyncThrowingStream<CLLocation, Error> { continuation in
            createdContinuation = continuation
        }
        // Now that we have the continuation, register it on the main actor and set up termination cleanup
        self.continuations[id] = createdContinuation
        createdContinuation.onTermination = { [id] _ in
            // This closure may be @Sendable; hop back to the main actor to touch self safely
            Task { @MainActor in
                self.continuations[id] = nil
            }
        }
        return stream
    }
    


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("*** CLLocationManager.didUpdateLocations ***")
        for location in locations {
            // For AsyncStream solution
            for continuation in continuations.values {
                continuation.yield(location)
            }
            
            // For Combine solution
            listeners.invoke { $0.didReceiveLocationUpdate(location) }
        }
    }
    
    deinit {
        print("AsyncLocationStream deinit called")
    }
}

@MainActor
protocol AsyncLocationStreamListener {
    func didReceiveLocationUpdate(_ location: CLLocation)
}

