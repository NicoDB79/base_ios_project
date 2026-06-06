//
//  OrderListModels.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//  
//

import UIKit

struct UIOrder: Identifiable {
    let id = UUID()
    var code: String = ""
}

class OrderListModels: ObservableObject {
    @Published var uiOrders: [UIOrder] = []
    @Published var serverUrl: String = ""
}
