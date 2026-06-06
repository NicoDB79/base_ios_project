//
//  OrderRepositoryImpl.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//

import Foundation
import Domain

public class OrderRepositoryImpl: OrderRepository {
    public init() {}
    public func loadOrders() async throws -> [Order] {
        try? await Task.sleep(nanoseconds: 2_000_000)
        return [Order(code: "AAA"), Order(code: "BBB")]
    }
}
