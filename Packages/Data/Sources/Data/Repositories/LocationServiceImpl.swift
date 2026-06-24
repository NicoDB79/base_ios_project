//
//  LocationServiceImpl.swift
//  BaseProject
//
//  Created by Nicola De Bei on 07/02/25.
//

import Foundation
import CoreLocation
import Domain

public final class LocationServiceImpl: LocationService, @unchecked Sendable {
    private let asyncLocationStream: AsyncLocationStream

    @MainActor
    public init() {
        self.asyncLocationStream = AsyncLocationStream()
    }

    public func startLocationUpdates() async {
        await asyncLocationStream.startLocationUpdates()
    }

    public func stopLocationUpdates() async {
        await asyncLocationStream.stopLocationUpdates()
    }

    public func observeLocationUpdates() async -> AsyncThrowingStream<CLLocation, any Error> {
        await asyncLocationStream.observeLocationUpdates()
    }
}
