//
//  Notification+Extension.swift
//  BaseProject
//
//  Created by Nicola De Bei on 09/02/23.
//

import Foundation

extension Notification.Name {
    static let disconnectionRequest = Notification.Name("disconnection.request")
    static let reconnectionRequest = Notification.Name("reconnection.request")
    static let pairingCompleted = Notification.Name("pairing.completed")
    static let disconnected = Notification.Name("disconnected")
}
