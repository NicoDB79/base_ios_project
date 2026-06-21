//
//  LocationViewModel.swift
//  BaseProject
//
//  Created by Nicola De Bei on 07/02/25.
//  
//

import Foundation
import Combine
import FactoryKit
import CoreLocation

// MARK: DataStore Protocol
protocol LocationDataStore {
  
}

// MARK: ViewModel Protocol
@MainActor
protocol LocationViewModelProtocol {
    var model: LocationModels { get set }
    func startFetchLocations()
    func stopFetchLocations()
}

@MainActor
class LocationViewModel: BaseViewModel, LocationViewModelProtocol, LocationDataStore {
    @Injected(\Container.startFetchLocationUseCase) private var startFetchLocationUseCase
    @Injected(\Container.stopFetchLocationUseCase) private var stopFetchLocationUseCase
    @Injected(\Container.observeLocationUseCase) private var observeLocationUseCase
    @Injected(\Container.observeCombineLocationUseCase) private var observeCombineLocationUseCase

    var locationTask: Task<(), Error>?

    func startFetchLocations() {
        startFetchLocationUseCase.execute()
        //observeCombineLocations()
        observeLocations()
    }

    func stopFetchLocations() {
        locationTask?.cancel()
        //stopFetchLocationUseCase.execute()
        //removeSubscriptions()
    }

    private func observeLocations() {
        let locations = observeLocationUseCase.execute()
        locationTask = Task { [weak self] in
            guard let self else { return }
            do {
                for try await location in locations {
                    print("LocationViewModel - received AsyncStream location: \(location.coordinate)")
                    self.model.uiLocation = location.toUI()
                }
            } catch {
                print("Error fetching location updates")
            }
        }
    }
    
    private func observeCombineLocations() {
        observeCombineLocationUseCase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let anError):
                    print("received error trying to observe locations: \(anError)")
                    break
                }
            }, receiveValue: { [weak self] location in
                  if let loc = location {
                      print("LocationViewModel - received Combine location: \(loc.coordinate)")
                      self?.model.uiLocation = loc.toUI()
                  }
              }
        )
        .store(in: &cancellables)
    }
    
    // MARK: LocationDataStore
    
    
    // MARK: - LocationViewModelProtocol
    var model = LocationModels()
    
    deinit {
        print("LocationViewModel deinit called")
        locationTask?.cancel()
    }
}

extension CLLocation {
    func toUI() -> UILocation {
        return UILocation(
            latitude: "Latitude: \(coordinate.latitude)",
            longitude: "Longitude: \(coordinate.longitude)"
        )
    }
}
