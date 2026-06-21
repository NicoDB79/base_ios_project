//
//  ObserveLocationUpatesUseCase.swift
//  BaseProject
//
//  Created by Nicola De Bei on 10/02/25.
//

import Foundation
import CoreLocation

public final class ObserveLocationUpatesUseCase: Sendable {
    public let locationService: any LocationService

    public init(locationService: any LocationService) {
        self.locationService = locationService
    }

    public func execute() async -> AsyncThrowingStream<CLLocation, Error> {
        await locationService.observeLocationUpdates()
    }
}
