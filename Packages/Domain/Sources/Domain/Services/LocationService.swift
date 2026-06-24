//
//  LocationService.swift
//  BaseProject
//
//  Created by Nicola De Bei on 07/02/25.
//

import Foundation
import CoreLocation

public protocol LocationService: Sendable {
    func startLocationUpdates() async
    func stopLocationUpdates() async
    func observeLocationUpdates() async -> AsyncThrowingStream<CLLocation, Error>
}
