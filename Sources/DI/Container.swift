//
//  Container.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//

import Foundation
import FactoryKit
import SwiftData
import Domain
import Data

extension Container {
    var modelContainer: Factory<ModelContainer> {
        self {
            do {
                return try AppDatabase.makeModelContainer()
            } catch {
                fatalError("Failed to create ModelContainer: \(error)")
            }
        }.singleton
    }

    var orderRepository: Factory<any OrderRepository> {
        self {
            OrderRepositoryImpl(modelContainer: self.modelContainer.resolve())
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
    
    var seedIfNeededUseCase: Factory<SeedIfNeededUseCase> {
        self {
            SeedIfNeededUseCase(orderRepository: self.orderRepository.resolve())
        }
    }

}

