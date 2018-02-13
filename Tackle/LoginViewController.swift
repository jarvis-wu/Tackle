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
            if let user = authDataResult?.user {
                let avatarName = self.getRandomAvatar()
                let userMetaData = UserMetadata(userName: user.displayName!, userEmail: user.email!, userAvatarName: avatarName)
                TackleManager.shared.updateSetting(withKey: Constants.UserDefaultsKeys.CurrentUserMetadata, withValue: userMetaData)
            }
            presentTabVC()
        }
    }
    
    func login() {
        let authUI = FUIAuth.defaultAuthUI()
        let providers: [FUIAuthProvider] = [FUIGoogleAuth()]
        authUI?.delegate = self
        authUI?.providers = providers
        authUI?.isSignInWithEmailHidden = true
        let authViewController = LoginPickerViewController(authUI: authUI!)
        present(authViewController, animated: true, completion: nil)
    }
    
    func presentTabVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabViewController = storyboard.instantiateViewController(withIdentifier: "TabViewController")
        present(tabViewController, animated: true, completion: nil)
    }
    
    private func getRandomAvatar() -> String {
        let avatars = Constants.Avatars.avatars
        let randomIndex = Int(arc4random_uniform(UInt32(avatars.count)))
        return avatars[randomIndex]
    }

}

extension FUIAuthBaseViewController {
    open override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.leftBarButtonItem = nil
    }
}

