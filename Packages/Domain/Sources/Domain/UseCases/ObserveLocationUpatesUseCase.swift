//
//  ObserveLocationUpatesUseCase.swift
//  BaseProject
//
//  Created by Nicola De Bei on 10/02/25.
//

import Foundation
import CoreLocation

public class ObserveLocationUpatesUseCase {
    public let locationService: LocationService
    
    public init(locationService: LocationService) {
        self.locationService = locationService
    }
    
    public func execute() -> AsyncThrowingStream<CLLocation, Error> {
        locationService.observeLocationUpdates()
    }
}
