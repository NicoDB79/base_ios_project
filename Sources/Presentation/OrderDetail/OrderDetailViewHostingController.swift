//
//  OrderDetailViewHostingController.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//  
//

import UIKit
import SwiftUI

class OrderDetailViewHostingController: BaseUIHostingController<OrderDetailView> {
    
    // MARK: - ViewModel
    var viewModel: (OrderDetailViewModelProtocol & BaseViewModel)
    
    // MARK: - Router
    var router: (OrderDetailRouterProtocol & OrderDetailDataPassing)?
    
    init(vm: OrderDetailViewModelProtocol & BaseViewModel) {
        viewModel = vm
        let swiftUIView = OrderDetailView(model: vm.model)
        super.init(rootView: swiftUIView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        viewModel.loadOrder()
        
        rootView.callback = {
            print("callback")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBinding()
    }
    
    private func setupUI() {
        setupBackButton()
    }
    
    private func setupBinding() {
        
    }
}
