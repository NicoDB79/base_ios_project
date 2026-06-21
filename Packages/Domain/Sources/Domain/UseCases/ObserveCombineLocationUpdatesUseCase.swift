//
//  ObserveCombineLocationUpdatesUseCase.swift
//  BaseProject
//
//  Created by Nicola De Bei on 10/02/25.
//

import Foundation
import CoreLocation
import Combine

@MainActor
public class ObserveCombineLocationUpdatesUseCase {
    public let locationService: any LocationService

    public init(locationService: any LocationService) {
        self.locationService = locationService
    }

    var locationDiscovered = PassthroughSubject<CLLocation?, Error>()

    public func execute() -> PassthroughSubject<CLLocation?, Error> {
        locationService.addListener(self)
        return locationDiscovered
    }
}

extension ObserveCombineLocationUpdatesUseCase: LocationServiceListener {
    public func didReceiveLocationUpdate(_ location: CLLocation) {
        locationDiscovered.send(location)
    }
}
