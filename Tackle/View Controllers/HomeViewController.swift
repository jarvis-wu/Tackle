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
        configureUI()
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
    
    private func configureUI() {
        let titleImageView = UIImageView(image: UIImage(named: "black-plane")?.resize(scaledToSize: CGSize(width: 25, height: 25)))
        titleImageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = titleImageView
        addPlusBarButton()
    }
    
    private func addPlusBarButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.addTarget(self, action: #selector(self.plusBarButtonPressed), for: UIControlEvents.touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        button.contentMode = .scaleAspectFit
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: button)]
    }
    
    @objc func plusBarButtonPressed() {
        print("Plus button pressed")
    }

}

