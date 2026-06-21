//
//  StopFetchLocationsUseCase.swift
//  BaseProject
//
//  Created by Nicola De Bei on 10/02/25.
//

import Foundation
import CoreLocation
import Combine

public class StopFetchLocationsUseCase {
    public let locationService: any LocationService

    public init(locationService: any LocationService) {
        self.locationService = locationService
    }
    
    @MainActor
    public func execute() {
        locationService.stopLocationUpdates()
    }
}
