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

@MainActor
public class LocationServiceImpl: LocationService {
    private let asyncLocationStream: AsyncLocationStream
    private var listeners: MulticastDelegate<any LocationServiceListener>

    public init() {
        self.asyncLocationStream = AsyncLocationStream()
        self.listeners = MulticastDelegate()
    }

    public func addListener(_ listener: any LocationServiceListener) {
        listeners.add(delegate: listener)
    }

    public func removeListener(_ listener: any LocationServiceListener) {
        listeners.remove(delegate: listener)
    }

    public func startLocationUpdates() {
        asyncLocationStream.addListener(self)
        asyncLocationStream.startLocationUpdates()
    }

    public func stopLocationUpdates() {
        asyncLocationStream.removeListener(self)
        asyncLocationStream.stopLocationUpdates()
    }

    public func observeLocationUpdates() -> AsyncThrowingStream<CLLocation, any Error> {
        asyncLocationStream.observeLocationUpdates()
    }
}

extension LocationServiceImpl: AsyncLocationStreamListener {
    func didReceiveLocationUpdate(_ location: CLLocation) {
        listeners.invoke { $0.didReceiveLocationUpdate(location) }
    }
}
