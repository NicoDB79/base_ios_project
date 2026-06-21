//
//  LocationService.swift
//  BaseProject
//
//  Created by Nicola De Bei on 07/02/25.
//

import Foundation
import CoreLocation
import Combine

@MainActor
public protocol LocationService: Sendable {
    func startLocationUpdates()
    func stopLocationUpdates()
    func observeLocationUpdates() -> AsyncThrowingStream<CLLocation, Error>
    func addListener(_ listener: any LocationServiceListener)
    func removeListener(_ listener: any LocationServiceListener)
}

@MainActor
public protocol LocationServiceListener: AnyObject {
    func didReceiveLocationUpdate(_ location: CLLocation)
}
