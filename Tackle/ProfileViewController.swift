//
//  ProfileViewController.swift
//  Tackle
//
//  Created by Jarvis Wu on 2018-02-10.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var avatarTopLabel: UILabel!
    
    @IBOutlet weak var avatarBottomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addEditBarButton()
    }
    
    private func configureUI() {
        let userMetadata = TackleManager.shared.getSetting(withKey: Constants.UserDefaultsKeys.CurrentUserMetadata) as! UserMetadata
        coverImageView.image = UIImage(named: "banner")
        avatarImageView.image = UIImage(named: userMetadata.userAvatarName)
        avatarImageView.layer.cornerRadius = Constants.UI.profileImageCornerRadius
        avatarImageView.layer.masksToBounds = true
        avatarTopLabel.text = userMetadata.userName
        avatarBottomLabel.text = userMetadata.userEmail
    }
    
    private func addEditBarButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "edit"), for: .normal)
        button.addTarget(self, action: #selector(self.editBarButtonPressed), for: UIControlEvents.touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        button.contentMode = .scaleAspectFit
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: button)]
    }
    
    @objc func editBarButtonPressed() {
        print("Edit pressed")
    }

}
