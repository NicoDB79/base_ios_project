//
//  Order.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//

import Foundation

public struct Order: Sendable {
    public let code: String
    public let orderDescription: String
    public let customer: String

    public init(code: String, orderDescription: String = "", customer: String = "") {
        self.code = code
        self.orderDescription = orderDescription
        self.customer = customer
    }
}
