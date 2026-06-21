//
//  ObserveLocationUpatesUseCase.swift
//  BaseProject
//
//  Created by Nicola De Bei on 10/02/25.
//

import Foundation
import CoreLocation

public class ObserveLocationUpatesUseCase {
    public let locationService: any LocationService

    public init(locationService: any LocationService) {
        self.locationService = locationService
    }
    
    @MainActor
    public func execute() -> AsyncThrowingStream<CLLocation, Error> {
        locationService.observeLocationUpdates()
    }
}
