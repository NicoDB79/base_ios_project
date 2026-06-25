//
//  OrderRepository.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//

import Foundation

public protocol OrderRepository: Sendable {
    func loadOrders() async throws -> [Order]
    func save(_ order: Order) async throws
    func seedIfNeeded() async throws
}
