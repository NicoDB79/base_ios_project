//
//  BaseUIHostingController.swift
//  BaseProject
//
//  Created by Nicola De Bei on 09/11/22.
//

import UIKit
import SwiftUI
import Combine
import SVProgressHUD

class BaseUIHostingController<Content>: UIHostingController<Content> where Content: View {
    
    /// references to event subscribers
    var cancellables = [AnyCancellable]()
    
    override init(rootView: Content) {
        super.init(rootView: rootView)
        // subscriptions to notifications will go here
    }
    
    /// required initializer
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationItem.hidesBackButton = true
    }
}
