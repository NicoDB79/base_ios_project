//
//  Toast.swift
//  eTruck
//
//  Created by Nicola De Bei on 28/03/18.
//  Copyright © 2018 Nicola De Bei. All rights reserved.
//

import Foundation

@MainActor
class Toast {
    static let shared = Toast()
    private var toastView: ToastView?
    
    func show(messageText: String, actionText: String, actionBlock: @escaping () -> ())
    {
        if toastView?.superview != nil {
            return
        }
        
        toastView = ToastView.instanceFromNib() as? ToastView
        toastView?.prepareToast(messageText: messageText, actionText: actionText, actionBlock: actionBlock)
        toastView?.show()
    }
    
    func hide() {
        if let t = toastView {
            t.hide()
        }
    }
}
