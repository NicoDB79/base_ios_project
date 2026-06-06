//
//  Toast.swift
//  BaseProject
//
//  Created by Nicola De Bei on 27/03/18.
//  Copyright © 2017 Nicola De Bei All rights reserved.
//
import UIKit

class ToastView: UIView
{
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var bottomConstraint: NSLayoutConstraint!
    
    static let initialHeight: CGFloat = 120.0
    static let finalHeight: CGFloat = -52.0
    static let toastDuration = 15.0
    
    var actionBlock: (()->())?
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ToastView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func prepareToast(messageText: String, actionText: String, actionBlock: @escaping () -> ())
    {
        let win: UIWindow = UIApplication.shared.keyWindow!
        
        win.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: ToastView.initialHeight)
        
        let leadingConstraint = NSLayoutConstraint(item: self, attribute: .leadingMargin, relatedBy: .equal, toItem: win, attribute: .leading, multiplier: 1, constant: 0.0)
        
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailingMargin, relatedBy: .equal, toItem: win, attribute: .trailing, multiplier: 1, constant: 0.0)
        
        bottomConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: win, attribute: .bottomMargin, multiplier: 1, constant: ToastView.initialHeight)
        
        win.addConstraints([heightConstraint, leadingConstraint, trailingConstraint, bottomConstraint!])

        self.messageLabel.text = messageText
        self.actionButton.isUserInteractionEnabled = true
        self.actionButton.setTitle(actionText, for: .normal)
        self.actionButton.titleLabel?.numberOfLines = 1
        self.actionButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.actionButton.titleLabel?.lineBreakMode = .byClipping
        self.actionButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        self.actionBlock = actionBlock
    }
    
    @objc func buttonTapped(sender: UIButton) {
        self.actionBlock?()
    }
    
    func show() {
        self.superview?.layoutIfNeeded()
        self.bottomConstraint!.constant = ToastView.finalHeight
        
        UIView.animate(withDuration
            :1.0, delay: 0.5, options: [UIView.AnimationOptions.allowUserInteraction], animations: { () -> Void in
                
                self.superview?.layoutIfNeeded()
                
        }, completion: { (value: Bool) in
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + ToastView.toastDuration, execute: {
                self.hide()
            })
        
        })
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(hide))
        swipeDown.direction = .down
        swipeDown.delegate = self
        self.superview?.addGestureRecognizer(swipeDown)
    }
    
    @objc func hide() {
        UIView.animate(withDuration:1.0, delay: 0.0, options: [UIView.AnimationOptions.allowUserInteraction], animations: { () -> Void in
            
            self.bottomConstraint!.constant = ToastView.initialHeight
            self.superview?.layoutIfNeeded()
            
        },  completion: {
            (value: Bool) in
            self.removeFromSuperview()
        })
    }
    
}

extension ToastView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
