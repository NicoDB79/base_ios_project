//
//  BaseViewModelProtocol.swift
//  iOSBaseProject
//
//  Created by Nicola De Bei on 16/12/21.
//

import Foundation
import Combine

protocol BaseViewModelProtocol {
    var loadingState: LoadingState { get }
    var loadingStatePublisher: Published<LoadingState>.Publisher { get }
    var cancellables: [AnyCancellable] { get set }
}


class BaseViewModel: BaseViewModelProtocol, ObservableObject {
    
    var cancellables: [AnyCancellable] = []
    
    @Published var loadingState: LoadingState = .none
    var loadingStatePublisher: Published<LoadingState>.Publisher { $loadingState }
    
    func removeSubscriptions() {
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
    }
    
    deinit {
        removeSubscriptions()
    }
}
