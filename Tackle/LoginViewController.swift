//
//  LoginViewController.swift
//  Tackle
//
//  Created by Zhaowei Wu on 2018-01-21.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI

class LoginViewController: UIViewController, FUIAuthDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLoginStatus()
    }
    
    func checkLoginStatus() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("User \(user.displayName!) has already signed in")
                self.presentTabVC()
            } else {
                self.login()
            }
        }
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            presentTabVC()
        }
    }
    
    func login() {
        let authUI = FUIAuth.defaultAuthUI()
        let providers: [FUIAuthProvider] = [FUIGoogleAuth()]
        authUI?.delegate = self
        authUI?.providers = providers
        authUI?.isSignInWithEmailHidden = true
        let authViewController = authUI?.authViewController()
        present(authViewController!, animated: true, completion: nil)
    }
    
    func presentTabVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabViewController = storyboard.instantiateViewController(withIdentifier: "TabViewController")
        present(tabViewController, animated: true, completion: nil)
    }

}
