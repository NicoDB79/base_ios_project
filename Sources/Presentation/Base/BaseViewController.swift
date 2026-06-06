//
//  BaseViewController.swift
//  iOSBaseProject
//
//  Created by Nicola De Bei on 16/12/21.
//

import UIKit
import Combine

class BaseViewController: UIViewController, Storyboarded {

    var cancellables: [AnyCancellable] = []
    
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
}
