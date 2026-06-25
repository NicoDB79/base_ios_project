//
//  SeedIfNeededUseCase.swift
//  BaseProject
//
//  Created by Nicola De Bei on 10/02/25.
//

import Foundation
import CoreLocation

public final class SeedIfNeededUseCase: Sendable {
    public let orderRepository: any OrderRepository

    public init(orderRepository: any OrderRepository) {
        self.orderRepository = orderRepository
    }

    public func execute() async {
        try? await orderRepository.seedIfNeeded()
    }
}
