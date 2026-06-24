//
//  LocationViewModel.swift
//  BaseProject
//
//  Created by Nicola De Bei on 07/02/25.
//

import Foundation
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

    var locationTask: Task<(), Error>?

    func startFetchLocations() {
        Task {
            await startFetchLocationUseCase.execute()
            await observeLocations()
        }
    }

    func stopFetchLocations() {
        locationTask?.cancel()
    }

    private func observeLocations() async {
        let locations = await observeLocationUseCase.execute()
        locationTask = Task { [weak self] in
            guard let self else { return }
            do {
                for try await location in locations {
                    print("LocationViewModel - received location: \(location.coordinate)")
                    self.model.uiLocation = location.toUI()
                }
            } catch {
                print("Error fetching location updates")
            }
        }
    }

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
