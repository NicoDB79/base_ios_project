//
//  UIViewController+Extensions.swift
//  BaseProject
//
//  Created by Nicola De Bei on 09/11/22.
//

import Foundation
import SVProgressHUD

extension UIViewController {
    func showActivity() {
        SVProgressHUD.show()
    }
    
    func hideActivity() {
        SVProgressHUD.dismiss()
    }
    
    func showInfoMessage(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
    
    func showProgress(title: String, progress: Float) {
        SVProgressHUD.showProgress(progress, status: title)
    }
    
    func showAlert(alertText: String, alertMessage: String, completion: (()->())? = nil) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            completion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupDefaultUI() {
        view.backgroundColor = Asset.Colors.backgroundMain.color
        navigationController?.navigationBar.isTranslucent = false
        //navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.setupNavigationBar()
    }
    
    // Return List Button
    func setBarButtonItems(showDisconnect: Bool = false) {
        let devicesItem = UIBarButtonItem(image: Asset.Media.listIcn.image,
                                          landscapeImagePhone: nil,
                                          style: .plain,
                                          target: self,
                                          action: #selector(Self.showDeviceList(sender:)))
        devicesItem.tintColor = Asset.Colors.textMain.color
        navigationItem.setLeftBarButton(devicesItem, animated: false)
        
        /*
        if showDisconnect {
            let disconnectItem = UIBarButtonItem(image: Asset.Media.disconnectIcn.image,
                                                 landscapeImagePhone: nil,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(Self.disconnectDevice(sender:)))
            disconnectItem.tintColor = Asset.Colors.textMain.color
            navigationItem.setRightBarButton(disconnectItem, animated: false)
        }
        */
    }
    /*
    func setTextToSpeech(active: Bool) {
        let ttsItem = UIBarButtonItem(image: Asset.Media.texttospeechIcn.image,
                                             landscapeImagePhone: nil,
                                             style: .plain,
                                             target: self,
                                             action: #selector(Self.toggleTTS(sender:)))
        ttsItem.tintColor = active ? Asset.Colors.textSuccess.color : Asset.Colors.textMain.color
        navigationItem.setRightBarButton(ttsItem, animated: false)
    }
    
    func setExportItem() {
        let exportItem = UIBarButtonItem(image: Asset.Media.exportIcn.image,
                                          landscapeImagePhone: nil,
                                          style: .plain,
                                          target: self,
                                          action: #selector(Self.showExportOptions(sender:)))
        exportItem.tintColor = Asset.Colors.textMain.color
        self.navigationItem.rightBarButtonItems = [exportItem]
    }
    
    
    func setSaveButtonItem(enabled: Bool = true) {
        let saveItem = UIBarButtonItem(title: L10n.supportEditSave,
                                          style: .plain,
                                          target: self,
                                          action: #selector(Self.saveAction(sender:)))

        saveItem.setTitleTextAttributes([
            NSAttributedString.Key.font : FontFamily.NotoSans.condensedBold.font(size: 14),
            NSAttributedString.Key.foregroundColor : Asset.Colors.textButtonDisabled.color
        ], for: .disabled)
        
        saveItem.setTitleTextAttributes([
            NSAttributedString.Key.font : FontFamily.NotoSans.condensedBold.font(size: 14),
            NSAttributedString.Key.foregroundColor : Asset.Colors.textMain.color
        ], for: [.normal])
        
        saveItem.setTitleTextAttributes([
            NSAttributedString.Key.font : FontFamily.NotoSans.condensedBold.font(size: 14),
            NSAttributedString.Key.foregroundColor : Asset.Colors.textMain.color
        ], for: [.selected])
        
        saveItem.isEnabled = enabled
        
        navigationItem.setRightBarButton(saveItem, animated: false)
    }
     */
    
    @objc func showDeviceList(sender: UIBarButtonItem) {}
    
    @objc func disconnectDevice(sender: UIBarButtonItem) {}
    
    @objc func showExportOptions(sender: UIBarButtonItem) {}
    
    @objc func saveAction(sender: UIBarButtonItem) {}
    
    @objc func toggleTTS(sender: UIBarButtonItem) {}
    
    
    // Custom Back Button
    func setupBackButton() {
        let newBackButton = UIBarButtonItem(image: Asset.Media.backButton.image, style: .plain, target: self, action: #selector(UIViewController.back(sender:)))
        newBackButton.tintColor = Asset.Colors.textMain.color
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

/*
extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}
*/
