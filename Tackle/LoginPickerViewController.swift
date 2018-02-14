//
//  LoginPickerViewController.swift
//  Tackle
//
//  Created by Jarvis Wu on 2018-02-13.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit
import FirebaseAuthUI

class LoginPickerViewController: FUIAuthPickerViewController {

    override init(nibName: String?, bundle: Bundle?, authUI: FUIAuth) {
        super.init(nibName: "FUIAuthPickerViewController", bundle: bundle, authUI: authUI)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // TODO: change constants according to device to avoid inconsistent UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: -45, width: width, height: height + 75))
        imageViewBackground.image = UIImage(named: "login-bg")
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        view.insertSubview(imageViewBackground, at: 0)
        let logoView = UIImageView(frame: CGRect(x: width / 2 - 40, y: 100, width: 80, height: 80))
        logoView.image = UIImage(named: "white-plane")
        let label = UILabel(frame: CGRect(x: width / 2 - 75, y: 170, width: 150, height: 80))
        label.text = "Tackle"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "MarkerFelt-Thin", size: 40)
        view.addSubview(logoView)
        view.addSubview(label)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
