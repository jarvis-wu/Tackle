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

class TackleManager {
    
    static let shared = TackleManager()
    
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
    
    func updateSetting(withKey key: String, withValue value: Any) {
        let defaults = UserDefaults.standard
        // TODO: remove string literals to Constants and replace if stmt with switch case
        switch key {
        case Constants.UserDefaultsKeys.InstabugIsOn:
            let bool = value as! Bool
            defaults.set(bool, forKey: key)
        default:
            break
        }
        
    }
    
    func getSetting(withKey key: String) -> Any? {
        let defaults = UserDefaults.standard
        // TODO: remove string literals to Constants and replace if stmt with switch case
        var result: Any?
        switch key {
        case Constants.UserDefaultsKeys.InstabugIsOn:
            result = defaults.value(forKey: key)
        default:
            break
        }
        return result
    }
    
    
}
