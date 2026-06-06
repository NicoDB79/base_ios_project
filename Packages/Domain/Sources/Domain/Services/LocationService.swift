//
//  LocationService.swift
//  BaseProject
//
//  Created by Nicola De Bei on 07/02/25.
//

import Foundation
import CoreLocation
import Combine

public protocol LocationService {
    func startLocationUpdates()
    func stopLocationUpdates()
    func observeLocationUpdates() -> AsyncThrowingStream<CLLocation, Error> // only for Aync solution, not for Combine
    
    func addListener(_ listener: LocationServiceListener)
    func removeListener(_ listener: LocationServiceListener) 
}

public protocol LocationServiceListener {
    func didReceiveLocationUpdate(_ location: CLLocation)
}
