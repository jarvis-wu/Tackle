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

struct UserMetadata: Codable {
    var userName: String
    var userEmail: String
    var userAvatarName: String
}

struct MenuItem {
    var labelName: String
    var leftImageName: String
}

class TackleManager {
    
    static let shared = TackleManager()
    
    // TODO: Add helper function to get user data more easily and avoid requesting UserDefaults directly
    
    // MARK: Instabug
    
    func startInstabug() {
        guard (TackleManager.shared.getSetting(withKey: Constants.UserDefaultsKeys.InstabugIsOn) == nil) ||
            (TackleManager.shared.getSetting(withKey: Constants.UserDefaultsKeys.InstabugIsOn) as! Bool == true)
            else { return }
        Instabug.setPrimaryColor(Constants.Colors.instabugYellow)
        Instabug.setShakingThresholdForiPhone(1.5, foriPad: 0.6)
        Instabug.setInvocationEvent(.shake)
        Instabug.setUserStepsEnabled(true)
        Instabug.setCrashReportingEnabled(true)
        Instabug.setPushNotificationsEnabled(true)
        Instabug.setPromptOptionsEnabledWithBug(true, feedback: true, chat: true)
        Instabug.start(withToken: "431a498a648f08224b6aee8894ff6cc4", invocationEvent: .shake)
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
