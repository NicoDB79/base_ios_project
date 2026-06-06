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
    
    @MainActor
    var locationService: Factory<LocationService> {
        self {
            LocationServiceImpl()
        }.singleton
    }
    
    @MainActor
    var startFetchLocationUseCase: Factory<StartFetchLocationsUseCase> {
        self {
            StartFetchLocationsUseCase(locationService: self.locationService.resolve())
        }
    }
    
    @MainActor
    var stopFetchLocationUseCase: Factory<StopFetchLocationsUseCase> {
        self {
            StopFetchLocationsUseCase(locationService: self.locationService.resolve())
        }
    }
    
    @MainActor
    var observeLocationUseCase: Factory<ObserveLocationUpatesUseCase> {
        self {
            ObserveLocationUpatesUseCase(locationService: self.locationService.resolve())
        }
    }
    
    @MainActor
    var observeCombineLocationUseCase: Factory<ObserveCombineLocationUpdatesUseCase> {
        self {
            ObserveCombineLocationUpdatesUseCase(locationService: self.locationService.resolve())
        }
    }
}

