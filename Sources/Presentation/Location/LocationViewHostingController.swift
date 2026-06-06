//
//  LocationViewHostingController.swift
//  BaseProject
//
//  Created by Nicola De Bei on 07/02/25.
//  
//

import UIKit
import SwiftUI

class LocationViewHostingController: BaseUIHostingController<LocationView> {
    
    // MARK: - ViewModel
    var viewModel: (LocationViewModelProtocol & BaseViewModel)
    
    // MARK: - Router
    var router: (LocationRouterProtocol & LocationDataPassing)?
    
    init(vm: LocationViewModelProtocol & BaseViewModel) {
        viewModel = vm
        let swiftUIView = LocationView(model: vm.model)
        super.init(rootView: swiftUIView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        rootView.callback = {
            print("callback")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBinding()
        
        
        //Task {
            viewModel.startFetchLocations()
        //}
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stopFetchLocations()
    }
    
    private func setupUI() {
        setupBackButton()
    }
    
    private func setupBinding() {
        
    }
}
