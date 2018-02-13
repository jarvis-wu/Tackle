//
//  TackleManager.swift
//  Tackle
//
//  Created by Jarvis Wu on 2018-02-08.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import Foundation
import UIKit
import Instabug
import Reachability

struct UserMetadata: Codable {
    var userName: String
    var userEmail: String
    var userAvatarName: String
}

struct MenuItem {
    var labelName: String
    var leftImageName: String
}

class TackleManager: NSObject {
    
    static let shared = TackleManager()
    
    // MARK: Reachability
    
    public var isOffline = false {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "networkStateHasChanged"), object: nil)
        }
    }
    
    func shouldShowOfflineMessage(fromViewController vc: UIViewController) {
        if isOffline != false {
            for subview in vc.navigationController!.view.subviews {
                if subview is ToastMessageView {
                    print(subview)
                    subview.removeFromSuperview()
                }
            }
            let tabBarFrame = vc.tabBarController!.tabBar.frame
            let frame = CGRect(x: 0, y: tabBarFrame.origin.y - 25, width: tabBarFrame.width, height: 25)
            let toastMessageView = ToastMessageView(frame: frame)
            vc.navigationController?.view.addSubview(toastMessageView)
        }
    }
    
    func shouldShowOnlineMessage(fromViewController vc: UIViewController) {
        if isOffline == false {
            for subview in vc.navigationController!.view.subviews {
                if subview is ToastMessageView {
                    subview.removeFromSuperview()
                }
            }
            let tabBarFrame = vc.tabBarController!.tabBar.frame
            let frame = CGRect(x: 0, y: tabBarFrame.origin.y - 25, width: tabBarFrame.width, height: 25)
            let toastMessageView = ToastMessageView(frame: frame)
            toastMessageView.backgroundView.backgroundColor = Constants.Colors.toastGreen
            toastMessageView.messageLabel.text = "Back online"
            vc.navigationController?.view.addSubview(toastMessageView)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
                toastMessageView.removeFromSuperview()
            })
        }
    }
    
    // TODO: Add helper function to get user data more easily and avoid requesting UserDefaults directly
    
    // MARK: Instabug
    
    func startInstabug() {
        guard (TackleManager.shared.getSetting(withKey: Constants.UserDefaultsKeys.InstabugIsOn) == nil) ||
            (TackleManager.shared.getSetting(withKey: Constants.UserDefaultsKeys.InstabugIsOn) as! Bool == true)
            else { return }
        Instabug.start(withToken: "431a498a648f08224b6aee8894ff6cc4", invocationEvent: .shake)
        Instabug.setPrimaryColor(Constants.Colors.instabugYellow)
        Instabug.setShakingThresholdForiPhone(1.5, foriPad: 0.6)
        Instabug.setInvocationEvent(.shake)
        Instabug.setUserStepsEnabled(true)
        Instabug.setCrashReportingEnabled(true)
        Instabug.setPushNotificationsEnabled(true)
        Instabug.setPromptOptionsEnabledWithBug(true, feedback: true, chat: true)
    }
    
    func stopInstabug() {
        Instabug.logOut()
        Instabug.setInvocationEvent(.none)
        Instabug.setUserStepsEnabled(false)
        Instabug.setCrashReportingEnabled(false)
        Instabug.setPushNotificationsEnabled(false)
        Instabug.setPromptOptionsEnabledWithBug(false, feedback: false, chat: false)
    }
    
    func showInstabugIntroMessage() {
        Instabug.showIntroMessage()
    }
    
    // MARK: UserDefaults
    
    // TODO: Consider making switch case more concise and less error-prone
    
    func updateSetting(withKey key: String, withValue value: Any) {
        let defaults = UserDefaults.standard
        switch key {
        case Constants.UserDefaultsKeys.InstabugIsOn:
            let bool = value as! Bool
            defaults.set(bool, forKey: key)
        case Constants.UserDefaultsKeys.CurrentUserMetadata:
            let metaData = value as! UserMetadata
            defaults.set(try? PropertyListEncoder().encode(metaData), forKey: Constants.UserDefaultsKeys.CurrentUserMetadata)
        default:
            print("Error: input key is undefined in updateSetting()")
        }
        
    }
    
    func getSetting(withKey key: String) -> Any? {
        let defaults = UserDefaults.standard
        var result: Any?
        switch key {
        case Constants.UserDefaultsKeys.InstabugIsOn:
            result = defaults.value(forKey: key)
        case Constants.UserDefaultsKeys.CurrentUserMetadata:
            if let data = defaults.value(forKey: Constants.UserDefaultsKeys.CurrentUserMetadata) as? Data {
                result = try? PropertyListDecoder().decode(UserMetadata.self, from: data)
            } else {
                print("ERROR")
            }
        default:
            print("Error: input key is undefined in getSetting()")
        }
        return result
    }
    
    
}
