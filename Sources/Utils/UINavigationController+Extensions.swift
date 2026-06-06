//
//  UINavigationController+Extensions.swift
//  BaseProject
//
//  Created by Nicola De Bei on 14/12/22.
//

import Foundation
import UIKit

extension UINavigationController {
    func setupNavigationBar() {
        let navigationBarAppearace = UINavigationBarAppearance()
        navigationBarAppearace.configureWithTransparentBackground()
        navigationBarAppearace.titleTextAttributes = [
            .foregroundColor: Asset.Colors.textMain.color,
            .font: FontFamily.NotoSans.condensedBold.font(size: 20)]
        navigationBarAppearace.backgroundColor = Asset.Colors.backgroundSecondary.color
        
        navigationBar.tintColor = Asset.Colors.textMain.color
        navigationBar.standardAppearance = navigationBarAppearace
        navigationBar.scrollEdgeAppearance = navigationBarAppearace
        
        navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        navigationBar.layer.shadowRadius = 20.0
        navigationBar.layer.shadowOpacity = 0.1
        navigationBar.layer.masksToBounds = false
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
