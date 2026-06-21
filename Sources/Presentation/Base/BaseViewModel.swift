//
//  BaseViewModelProtocol.swift
//  iOSBaseProject
//
//  Created by Nicola De Bei on 16/12/21.
//

import Foundation
import Combine

// Currently this class has been kept only to simplify the use of Cancellables, in case you decide to use Combine in your child viewmodels

@MainActor
protocol BaseViewModelProtocol {
    var cancellables: [AnyCancellable] { get set }
}

@MainActor
class BaseViewModel: BaseViewModelProtocol {

    var cancellables: [AnyCancellable] = []

    func removeSubscriptions() {
        cancellables.forEach { $0.cancel() }
    }
}
