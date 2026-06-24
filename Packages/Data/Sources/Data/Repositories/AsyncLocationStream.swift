//
//  AsyncLocationStream.swift
//  BaseProject
//
//  Created by Nicola De Bei on 07/02/25.
//

import Foundation
import CoreLocation

@MainActor
class AsyncLocationStream: NSObject, @MainActor CLLocationManagerDelegate {
    private var continuations: [UUID: AsyncThrowingStream<CLLocation, Error>.Continuation] = [:]
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func startLocationUpdates() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
        continuations.values.forEach { $0.finish() }
    }

    func observeLocationUpdates() -> AsyncThrowingStream<CLLocation, Error> {
        let id = UUID()
        var createdContinuation: AsyncThrowingStream<CLLocation, Error>.Continuation!
        let stream = AsyncThrowingStream<CLLocation, Error> { continuation in
            createdContinuation = continuation
        }
        continuations[id] = createdContinuation
        createdContinuation.onTermination = { [id] _ in
            Task { @MainActor in
                self.continuations[id] = nil
            }
        }
        return stream
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            for continuation in continuations.values {
                continuation.yield(location)
            }
        }
    }

    deinit {
        print("AsyncLocationStream deinit called")
    }
}
