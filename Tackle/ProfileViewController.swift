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

}
