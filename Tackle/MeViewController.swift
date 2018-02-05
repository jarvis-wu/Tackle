//
//  MeViewController.swift
//  Tackle
//
//  Created by Zhaowei Wu on 2018-01-13.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit
import FirebaseAuthUI

class MeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        try! FUIAuth.defaultAuthUI()?.signOut()
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true, completion: nil)
    }
    

}

