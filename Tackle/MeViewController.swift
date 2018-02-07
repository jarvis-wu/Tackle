//
//  MeViewController.swift
//  Tackle
//
//  Created by Zhaowei Wu on 2018-01-13.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit
import FirebaseAuthUI

struct MenuItem {
    var labelName: String
    var leftImageName: String
}

class MeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private let menuItemList: [[MenuItem]] = [
        [
            MenuItem(labelName: "Events", leftImageName: "calendar"),
            MenuItem(labelName: "Friends", leftImageName: "contacts"),
            MenuItem(labelName: "Files", leftImageName: "folder")
        ],
        [
            MenuItem(labelName: "Settings", leftImageName: "gears"),
            MenuItem(labelName: "Get help", leftImageName: "help"),
            MenuItem(labelName: "More", leftImageName: "more")
        ],
        [
            MenuItem(labelName: "Sign out", leftImageName: "shutdown")
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func showSignOutAlert() {
        let alertVC = UIAlertController(title: "Sign out", message: Constants.Strings.logoutAlertMessage, preferredStyle: .actionSheet)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuItemList.count + 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 1
        if section != 0 {
            numberOfRows = menuItemList[section - 1].count
        }
        return numberOfRows
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var resultCell = UITableViewCell()
        if indexPath.section != 0 {
            let cell = Bundle.main.loadNibNamed("MeTableViewCell", owner: self, options: nil)?.first as! MeTableViewCell
            cell.label.text = menuItemList[indexPath.section - 1][indexPath.row].labelName
            cell.leftImageView.image = UIImage(named: menuItemList[indexPath.section - 1][indexPath.row].leftImageName)
            resultCell = cell
        } else {
            let cell = Bundle.main.loadNibNamed("BigMeTableViewCell", owner: self, options: nil)?.first as! BigMeTableViewCell
            cell.leftImageView.image = UIImage(named: getRandomAvatar())
            cell.leftImageView.layer.cornerRadius = Constants.UI.profileImageCornerRadius
            cell.leftImageView.layer.masksToBounds = true
            cell.topLabel.text = Auth.auth().currentUser?.displayName
            cell.bottomLabel.text = Auth.auth().currentUser?.email
            cell.middleImageView.image = UIImage(named: "edit")
            resultCell = cell
        }
        return resultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let numOfSections = numberOfSections(in: tableView)
        if indexPath.section == 2 {
            if indexPath.row == 2 {
                performSegue(withIdentifier: "showMore", sender: self)
            }
        }
        if indexPath.section == numOfSections - 1 {
            if indexPath.row == tableView.numberOfRows(inSection: numOfSections - 1) - 1 {
                showSignOutAlert()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = Constants.UI.meTableViewCellHeight
        if indexPath.section == 0 {
            height = Constants.UI.bigMeTableViewCellHeight
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.UI.meTableViewSectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constants.UI.meTableViewSectionFooterHeight
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Will trigger \(segue.identifier ?? "unknown") segue")
    }
    
    private func getRandomAvatar() -> String {
        let avatars = Constants.Avatars.avatars
        let randomIndex = Int(arc4random_uniform(UInt32(avatars.count)))
        return avatars[randomIndex]
    }

}

