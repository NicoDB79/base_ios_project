//
//  AppDelegate.swift
//  iOSBaseProject
//
//  Created by Nicola De Bei on 16/12/21.
//

import UIKit
import SVProgressHUD
import FactoryKit
import BackgroundTasks
import FirebaseCore
import Combine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appAlreadyInstalledKey = "already_installed"
    let syncTaskIdentifier = "com.company.baseproject.sync"
    var bgTask : UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    static let kCheckKey = "CHECK"
    
    @Injected(\Container.startFetchLocationUseCase) private var startFetchLocationUseCase
    @Injected(\Container.observeCombineLocationUseCase) private var observeCombineLocationUseCase
    @Injected(\Container.observeLocationUseCase) private var observeLocationUseCase
    var cancellables: [AnyCancellable] = []
    
    var locationTask: Task<(), Error>?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        clearKeychainOnFreshInstall()
        
#if DEBUG
        //TODO: plant log tree of Crashlytics in debug
#else
        FirebaseApp.configure()
        //TODO: plant log tree of Crashlytics in release
#endif


        // Override point for customization after application launch.

        UIApplication.shared.applicationIconBadgeNumber = 0
        
        registerBackgroundTask()

        startFetchLocationUseCase.execute()
        
        // Combine Locations
        //observeCombineLocations()
        
        // AsyncStream Locations
        observeLocations()
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    private func clearKeychainOnFreshInstall() {
        let freshInstall = !UserDefaults.standard.bool(forKey: appAlreadyInstalledKey)
        if freshInstall {
            KeychainWrapper.wipeKeychain()
            KeychainWrapper.standard.set(true, forKey: Self.kCheckKey)
            UserDefaults.standard.set(true, forKey: appAlreadyInstalledKey)
            UserDefaults.standard.synchronize()
        }
    }

    private func registerBackgroundTask() {
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: syncTaskIdentifier,
            using: DispatchQueue.global()
        ) { task in
            self.syncData(task)
        }
    }

    private func syncData(_ task: BGTask) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            /*
            let result = self.appDataSyncWorker.performSync()
            task.setTaskCompleted(success: result)
             */
            task.expirationHandler = {
                task.setTaskCompleted(success: false)
            }
            self.scheduleSyncWorker()
        }
    }

    func scheduleSyncWorker() {
        do {
            let request = BGProcessingTaskRequest(identifier: syncTaskIdentifier)
            request.requiresExternalPower = false
            request.requiresNetworkConnectivity = true
            request.earliestBeginDate = Date(timeIntervalSinceNow: 60)
            try BGTaskScheduler.shared.submit(request)
            //KnfLog.d("TASK SUBMITTED")
            /*
             To simulate background fetch:
             1) put a brakepoint after the submit operation
             2) on console run: e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.company.baseproject.sync"]
             3) resume the app
             */
        } catch {
            print(error)
        }
    }
    
    func createBackGroundTask() {
        if bgTask == UIBackgroundTaskIdentifier.invalid {
            //KnfLog.d("*** Beginning background task")
            bgTask = UIApplication.shared.beginBackgroundTask(withName: "extensionTask", expirationHandler: {
                //KnfLog.d("*** Background task time expired")
                UIApplication.shared.endBackgroundTask(self.bgTask)
                self.bgTask = UIBackgroundTaskIdentifier.invalid
            })
        }
    }
    
    private func observeLocations() {
        let locations = observeLocationUseCase.execute()
        locationTask = Task { @MainActor in
            do {
                for try await location in locations {
                    print("AppDelegate - received AsyncStream location: \(location.coordinate)")
                }
            } catch {
                print("Error fetching location updates")
            }
        }
    }
    
    
    private func observeCombineLocations() {
        observeCombineLocationUseCase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let anError):
                    print("received error trying to observe locations: \(anError)")
                    break
                }
            }, receiveValue: { location in
                  if let loc = location {
                      print("AppDelegate - received Combine location: \(loc.coordinate)")
                  }
              }
        )
        .store(in: &cancellables)
    }
   
}

// MARK: UIApplication configurations
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    class func removeModals(completion: @escaping () -> ()) {
        if let topController = UIApplication.topViewController() {
            if topController.presentingViewController != nil {
                topController.dismiss(animated: true, completion: {
                    UIApplication.removeModals(completion: completion)
                })
            } else {
                completion()
            }
        }
    }
}

// MARK: UIWindow utility methods
extension UIWindow {
    func switchRootViewController(_ viewController: UIViewController,
                                  animated: Bool = true,
                                  duration: TimeInterval = 0.5,
                                  options: UIView.AnimationOptions = .transitionFlipFromRight,
                                  completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }) { _ in
            completion?()
        }
    }
}
