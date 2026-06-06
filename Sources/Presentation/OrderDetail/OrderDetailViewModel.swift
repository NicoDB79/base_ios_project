//
//  OrderDetailViewModel.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//  
//

import Foundation
import Combine
import Domain

// MARK: DataStore Protocol
protocol OrderDetailDataStore {
    var order: Order? { get set }
}

// MARK: ViewModel Protocol
protocol OrderDetailViewModelProtocol {
    var model: OrderDetailModels { get set }
    func loadOrder()
}

class OrderDetailViewModel: BaseViewModel, OrderDetailViewModelProtocol, OrderDetailDataStore {
    // MARK: OrderDetailDataStore
    var order: Order?
    
    // MARK: - OrderDetailViewModelProtocol
    var model = OrderDetailModels()
    
    func loadOrder() {
        if let uo = order?.toUI() {
            model.uiOrder = uo
        }
    }
}
