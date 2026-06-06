//
//  LocationRouter.swift
//  BaseProject
//
//  Created by Nicola De Bei on 07/02/25.
//  
//

import Foundation
import UIKit

// MARK: Router Data Passing
protocol LocationDataPassing
{
  var dataStore: LocationDataStore? { get set }
}

// MARK: Router Protocol
protocol LocationRouterProtocol {
    
}

class LocationRouter: LocationDataPassing {
    
    // MARK: DataStore
    var dataStore: LocationDataStore?
    
    // MARK: Properties
    weak var view: LocationViewHostingController?
    
    // MARK: Static methods
    static func createModule() -> LocationViewHostingController {
        
        //MARK: Initialise components.
        let viewModel = LocationViewModel()
        let router = LocationRouter()
        router.dataStore = viewModel
        let viewController = LocationViewHostingController(vm: viewModel)
        viewController.router = router
        router.view = viewController
        return viewController
    }
}

extension LocationRouter: LocationRouterProtocol {
    // TODO: Implement Router Methods
}
