//
//  MessageViewController.swift
//  Tackle
//
//  Created by Zhaowei Wu on 2018-01-14.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addReachabilityObserver()
    }
    
    private func addReachabilityObserver() {
        if TackleManager.shared.isOffline {
            TackleManager.shared.shouldShowOfflineMessage(fromViewController: self)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(networkStateHasChanged), name: NSNotification.Name(rawValue: "networkStateHasChanged"), object: nil)
    }
    
    @objc func networkStateHasChanged() {
        if TackleManager.shared.isOffline {
            TackleManager.shared.shouldShowOfflineMessage(fromViewController: self)
        } else {
            TackleManager.shared.shouldShowOnlineMessage(fromViewController: self)
        }
    }

}
