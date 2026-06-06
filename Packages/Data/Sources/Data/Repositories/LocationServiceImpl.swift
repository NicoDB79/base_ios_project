//
//  LocationServiceImpl.swift
//  BaseProject
//
//  Created by Nicola De Bei on 07/02/25.
//

import Foundation
import CoreLocation
import Combine
import Domain

public class LocationServiceImpl: @MainActor LocationService {
    private let asyncLocationStream: AsyncLocationStream
    private let listeners: MulticastDelegate<LocationServiceListener>

    @MainActor
    public init() {
        self.asyncLocationStream = AsyncLocationStream()
        self.listeners = MulticastDelegate<LocationServiceListener>()
    }
    
    public func addListener(_ listener: LocationServiceListener) {
        listeners.add(delegate: listener)
    }
    
    public func removeListener(_ listener: LocationServiceListener) {
        listeners.remove(delegate: listener)
    }
    
    @MainActor public func startLocationUpdates() {
        asyncLocationStream.addListener(self)
        asyncLocationStream.startLocationUpdates()
    }
    
    @MainActor public func stopLocationUpdates() {
        asyncLocationStream.removeListener(self)
        asyncLocationStream.stopLocationUpdates()
    }
    
    // Only for AsyncStream, not for Combine solution
    @MainActor public func observeLocationUpdates() -> AsyncThrowingStream<CLLocation, any Error> {
        asyncLocationStream.observeLocationUpdates()
    }
}

extension LocationServiceImpl: AsyncLocationStreamListener {
    func didReceiveLocationUpdate(_ location: CLLocation) {
        listeners.invoke { $0.didReceiveLocationUpdate(location) }
    }
}
