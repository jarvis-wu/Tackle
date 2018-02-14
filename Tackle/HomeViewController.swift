//
//  HomeViewController.swift
//  Tackle
//
//  Created by Zhaowei Wu on 2018-01-13.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var navBarItem: UINavigationItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        addReachabilityObserver()
        let titleImageView = UIImageView(image: UIImage(named: "black-plane")?.resize(scaledToSize: CGSize(width: 30, height: 30)))
        titleImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleImageView
    }
    
    func addReachabilityObserver() {
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

