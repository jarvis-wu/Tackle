//
//  HomeViewController.swift
//  Tackle
//
//  Created by Zhaowei Wu on 2018-01-13.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit
import Popover

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
        let popView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 200))
        let startPoint = CGPoint(x: self.view.frame.width - 30, y: self.navigationController!.navigationBar.frame.height + 20)
        let options = [
            PopoverOption.type(.down),
            PopoverOption.cornerRadius(10.0),
            PopoverOption.animationIn(0.3),
            PopoverOption.arrowSize(CGSize(width: 14, height: 10)),
            PopoverOption.blackOverlayColor(UIColor.clear),
            PopoverOption.color(UIColor.white),
            PopoverOption.sideEdge(15.0)
            ] as [PopoverOption]
        let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        popover.show(popView, point: startPoint)
    }

}

