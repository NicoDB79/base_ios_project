//
//  BaseViewModelProtocol.swift
//  iOSBaseProject
//
//  Created by Nicola De Bei on 16/12/21.
//

import Foundation
import Combine

protocol BaseViewModelProtocol {
    var cancellables: [AnyCancellable] { get set }
}

class BaseViewModel: BaseViewModelProtocol {

    var cancellables: [AnyCancellable] = []

    func removeSubscriptions() {
        cancellables.forEach { $0.cancel() }
    }

    deinit {
        removeSubscriptions()
    }
}
