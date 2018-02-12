//
//  AppDelegate.swift
//  Tackle
//
//  Created by Zhaowei Wu on 2018-01-13.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    let reachability = Reachability()!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // TODO: Not recommended. Consider change it later.
        Thread.sleep(forTimeInterval: 1.0)
        checkReachability()
        FirebaseApp.configure()
        TackleManager.shared.startInstabug()
        configureUI()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other url handling goes here
        return false
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        let defaultOrientations = UIInterfaceOrientationMask.allButUpsideDown
        guard let tabBarController = self.window?.rootViewController?.presentedViewController as? UITabBarController else { return defaultOrientations}
        guard let navBarController = tabBarController.selectedViewController as? UINavigationController else { return defaultOrientations }
        guard let meViewController = navBarController.topViewController as? MeViewController else { return defaultOrientations }
        if meViewController.isPresentingQRCodeViewController {
            return UIInterfaceOrientationMask.portrait
        } else {
            return defaultOrientations
        }
    }
    
    func checkReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
            TackleManager.shared.didGoOffline()
        }
    }
    
    func configureUI() {
        let navigationBarAppearance = UINavigationBar.appearance()
        let tabBarAppearance = UITabBar.appearance()
        navigationBarAppearance.barTintColor = Constants.Colors.tackleYellowLight
        navigationBarAppearance.tintColor = Constants.Colors.tackleYellowMid
        navigationBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor : Constants.Colors.tackleYellowMid]
        tabBarAppearance.barTintColor = Constants.Colors.tackleYellowLight
        tabBarAppearance.tintColor = Constants.Colors.tackleYellowMid
        self.window?.backgroundColor = UIColor.white
    }

}

