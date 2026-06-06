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
    
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgressHUD()
        setupSplashAnimation { [weak self] in
            self?.navigateToInitialModule()
        }
    }
    
    private func setupProgressHUD() {
        SVProgressHUD.setDefaultMaskType(.black)
        let mode: SVProgressHUDStyle = traitCollection.userInterfaceStyle == .dark ? .dark : .light
        SVProgressHUD.setDefaultStyle(mode)
    }
    
    private func setupSplashAnimation(completion: @escaping (()->())) {
        animationView = LottieAnimationView()
        animationView!.animation = traitCollection.userInterfaceStyle == .dark ? LottieAnimation.test : LottieAnimation.test
        animationView!.frame.size = CGSize(width: view.bounds.width*0.8, height: view.bounds.height*0.8)
        animationView!.center = CGPoint(x: UIScreen.main.bounds.size.width / 2,
                                        y: UIScreen.main.bounds.size.height / 2)
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .playOnce
        animationView!.animationSpeed = 1
        view.addSubview(animationView!)
        animationView!.play { _ in completion() }
    }
    
    private func navigateToInitialModule() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navigateToInitialModule()
    }
}
