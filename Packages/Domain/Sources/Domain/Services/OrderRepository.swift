//
//  OrderRepository.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//

import Foundation

public protocol OrderRepository {
    func loadOrders() async throws -> [Order]
}
