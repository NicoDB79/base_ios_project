//
//  OrderListRouter.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//  
//

import Foundation
import UIKit

// MARK: Router Data Passing
protocol OrderListDataPassing
{
  var dataStore: OrderListDataStore? { get set }
}

// MARK: Router Protocol
protocol OrderListRouterProtocol {
    func goToDetail(code: String)
}

class OrderListRouter: OrderListDataPassing {
    
    // MARK: DataStore
    var dataStore: OrderListDataStore?
    
    // MARK: Properties
    weak var view: OrderListViewHostingController?
    
    // MARK: Static methods
    static func createModule() -> OrderListViewHostingController {
        
        //MARK: Initialise components.
        let viewModel = OrderListViewModel()
        let router = OrderListRouter()
        router.dataStore = viewModel
        let viewController = OrderListViewHostingController(vm: viewModel)
        viewController.router = router
        router.view = viewController
        return viewController
    }
}

extension OrderListRouter: OrderListRouterProtocol {
    func goToDetail(code: String) {
        view?.navigationController?.pushViewController(LocationRouter.createModule(), animated: true)
        /*
        if let order = dataStore?.orders.first(where: { $0.code == code }) {
            let orderDetailVC = OrderDetailRouter.createModule()
            orderDetailVC.router?.dataStore?.order = order
            view?.navigationController?.pushViewController(orderDetailVC, animated: true)
        }
        */
    }
}
