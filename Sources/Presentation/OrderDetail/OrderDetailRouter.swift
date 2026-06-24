//
//  OrderDetailRouter.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//  
//

import Foundation
import UIKit

// MARK: Router Data Passing
protocol OrderDetailDataPassing
{
  var dataStore: OrderDetailDataStore? { get set }
}

// MARK: Router Protocol
protocol OrderDetailRouterProtocol {
    
}

class OrderDetailRouter: OrderDetailDataPassing {
    
    // MARK: DataStore
    var dataStore: OrderDetailDataStore?
    
    // MARK: Properties
    weak var view: OrderDetailViewHostingController?
    
    // MARK: Static methods
    @MainActor static func createModule() -> OrderDetailViewHostingController {
        
        //MARK: Initialise components.
        let viewModel = OrderDetailViewModel()
        let router = OrderDetailRouter()
        router.dataStore = viewModel
        let viewController = OrderDetailViewHostingController(vm: viewModel)
        viewController.router = router
        router.view = viewController
        return viewController
    }
}

extension OrderDetailRouter: OrderDetailRouterProtocol {
    // TODO: Implement Router Methods
}
