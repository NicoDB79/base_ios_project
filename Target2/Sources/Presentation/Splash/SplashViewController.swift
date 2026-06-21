//
//  SplashViewController.swift
//  BaseProject
//
//  Created by Nicola De Bei on 14/12/22.
//

import UIKit
import SVProgressHUD
import Lottie

class SplashViewController: UIViewController, Storyboarded {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgressHUD()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.navigateToInitialModule()
        }
    }
    
    private func setupProgressHUD() {
        SVProgressHUD.setDefaultMaskType(.black)
        let mode: SVProgressHUDStyle = traitCollection.userInterfaceStyle == .dark ? .dark : .light
        SVProgressHUD.setDefaultStyle(mode)
    }
    
    private func navigateToInitialModule() {
        guard let window = view.window else { return }
        let initialModule = UINavigationController(rootViewController: OrderListRouter.createModule())
        window.switchRootViewController(initialModule)
    }
}
