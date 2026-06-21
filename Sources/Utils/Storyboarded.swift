//
//  Storyboarded.swift
//  iOSBaseProject
//
//  Created by Nicola De Bei on 16/12/21.
//

import UIKit

enum Storyboard: String {
    case dashboard = "Dashboard"
    case service = "Service"
    case report = "Report"
    case info = "Info"
    case support = "Support"
}

protocol Storyboarded {}

@MainActor
extension Storyboarded where Self: UIViewController {
    static func instantiate(viewControllerId: String) -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: viewControllerId, bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
