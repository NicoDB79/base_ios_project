//
//  FetchLocationsUseCase.swift
//  BaseProject
//
//  Created by Nicola De Bei on 10/02/25.
//

import Foundation
import CoreLocation
import Combine

public class StartFetchLocationsUseCase {
    public let locationService: LocationService
    
    public init(locationService: LocationService) {
        self.locationService = locationService
    }
    
    public func execute() {
        locationService.startLocationUpdates()
    }
}
