//
//  OrderListViewHostingController.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//  
//

import UIKit
import SwiftUI

class OrderListViewHostingController: BaseUIHostingController<OrderListView> {
    
    // MARK: - ViewModel
    var viewModel: (OrderListViewModelProtocol & BaseViewModel)

    // MARK: - Router
    var router: (OrderListRouterProtocol & OrderListDataPassing)?

    private var loadTask: Task<Void, Never>?
    
    init(vm: OrderListViewModelProtocol & BaseViewModel) {
        viewModel = vm
        let swiftUIView = OrderListView(model: vm.model)
        super.init(rootView: swiftUIView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        rootView.orderSelected = { [weak self] code in
            self?.router?.goToDetail(code: code)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBinding()
        loadTask = Task { [weak self] in
            self?.viewModel.loadServerUrl()
            await self?.viewModel.loadOrders()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loadTask?.cancel()
    }
    
    private func setupUI() {
        
    }
    
    private func setupBinding() {
        
    }
}
