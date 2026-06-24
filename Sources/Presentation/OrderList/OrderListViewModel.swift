//
//  OrderListViewModel.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//  
//

import Foundation
import FactoryKit
import Domain

// MARK: DataStore Protocol
@MainActor
protocol OrderListDataStore {
    var orders: [Order] { get set }
}

// MARK: ViewModel Protocol
@MainActor
protocol OrderListViewModelProtocol {
    var model: OrderListModels { get set }
    func loadOrders() async
    func loadServerUrl()
}

class OrderListViewModel: BaseViewModel, OrderListViewModelProtocol, OrderListDataStore {
    @Injected(\Container.orderRepository) private var orderRepository
    
    // MARK: OrderListDataStore
    var orders: [Order] = []
    
    // MARK: - OrderListViewModelProtocol
    var model = OrderListModels()
    
    @MainActor
    func loadOrders() async {
        if let ods = try? await orderRepository.loadOrders() {
            self.orders = ods
            model.uiOrders = ods.map { $0.toUI()}
        }
    }
    
    func loadServerUrl() {
        model.serverUrl = Bundle.main.serverURLString ?? ""
    }
    
    
}


extension Order {
    func toUI() -> UIOrder {
        UIOrder(code: code)
    }
}
