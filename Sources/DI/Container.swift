//
//  Container.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//

import Foundation
import FactoryKit
import Domain
import Data

extension Container {
    var orderRepository: Factory<OrderRepository> {
        self {
            OrderRepositoryImpl()
        }.singleton
        
    }

    var locationService: Factory<any LocationService> {
        self {
            MainActor.assumeIsolated { LocationServiceImpl() }
        }.singleton
    }

    var startFetchLocationUseCase: Factory<StartFetchLocationsUseCase> {
        self {
            StartFetchLocationsUseCase(locationService: self.locationService.resolve())
        }
    }

    var stopFetchLocationUseCase: Factory<StopFetchLocationsUseCase> {
        self {
            StopFetchLocationsUseCase(locationService: self.locationService.resolve())
        }
    }

    var observeLocationUseCase: Factory<ObserveLocationUpatesUseCase> {
        self {
            ObserveLocationUpatesUseCase(locationService: self.locationService.resolve())
        }
    }

}

