//
//  MeViewController.swift
//  Tackle
//
//  Created by Zhaowei Wu on 2018-01-13.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit
import FirebaseAuthUI

class MeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    struct MenuItem {
        var labelName: String
        var leftImageName: String
    }
    
    private let menuItemList: [MenuItem] = [
        MenuItem(labelName: "Sign out", leftImageName: "shutdown")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func showSignOutAlert() {
        let alertVC = UIAlertController(title: "Sign out", message: "Are you sure that you want to sign out?", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            self.signOut()
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    private func signOut() {
        try! FUIAuth.defaultAuthUI()?.signOut()
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true, completion: nil)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MeTableViewCell", owner: self, options: nil)?.first as! MeTableViewCell
        cell.label.text = menuItemList[indexPath.row].labelName
        cell.leftImageView.image = UIImage(named: menuItemList[indexPath.row].leftImageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            showSignOutAlert()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

}

