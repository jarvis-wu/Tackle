//
//  MeSubViewController.swift
//  Tackle
//
//  Created by Jarvis Wu on 2018-02-07.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit
import FirebaseAuthUI

class MeSubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var menuItemList = [[MenuItem]]()
    
    public var sourceIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateMenu(fromIndexPath: sourceIndexPath)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuItemList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = menuItemList[section].count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MeTableViewCell", owner: self, options: nil)?.first as! MeTableViewCell
        cell.label.text = menuItemList[indexPath.section][indexPath.row].labelName
        cell.leftImageView.image = UIImage(named: menuItemList[indexPath.section][indexPath.row].leftImageName)
        // TODO: consider using switch case here
        if sourceIndexPath == IndexPath(row: 0, section: 3) { // instabug switch
            if indexPath == IndexPath(row: 0, section: 2) {
                cell.middleImageView.image = UIImage(named: "help-gray")
                let switchView = UISwitch()
                if let switchState = TackleManager.shared.getSetting(withKey: Constants.UserDefaultsKeys.InstabugIsOn) {
                    switchView.isOn = switchState as! Bool
                } else {
                    switchView.isOn = true
                }
                switchView.addTarget(self, action: #selector(stateChanged(switchState:)), for: UIControlEvents.valueChanged)
                cell.accessoryView = switchView
                cell.rightImageView.isHidden = true
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if sourceIndexPath == IndexPath(row: 0, section: 3) {
            if indexPath == IndexPath(row: 0, section: 0) {
                showFeatureUnavailableAlert()
            }
            if indexPath == IndexPath(row: 0, section: 1) {
                showFeatureUnavailableAlert()
            }
            if indexPath == IndexPath(row: 0, section: 2) {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                    TackleManager.shared.showInstabugIntroMessage()
                })
            }
            if indexPath == IndexPath(row: 0, section: 3) {
                showSignOutAlert()
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = Constants.UI.meTableViewCellHeight
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.UI.meTableViewSectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constants.UI.meTableViewSectionFooterHeight
    }
    
    private func populateMenu(fromIndexPath indexPath: IndexPath) {
        menuItemList = Constants.MenuItemLists.secondaryItemLists[indexPath.section][indexPath.row]
    }
    
    // Instabug switch
    @objc func stateChanged(switchState: UISwitch) {
        if switchState.isOn {
            TackleManager.shared.updateSetting(withKey: Constants.UserDefaultsKeys.InstabugIsOn, withValue: true)
            TackleManager.shared.startInstabug()
        } else {
            TackleManager.shared.updateSetting(withKey: Constants.UserDefaultsKeys.InstabugIsOn, withValue: false)
            TackleManager.shared.stopInstabug()
        }
    }
    
    private func showFeatureUnavailableAlert() {
        let alertVC = UIAlertController(title: "Sorry", message: Constants.Strings.featureUnavailableAlertMessage, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    private func showSignOutAlert() {
        let alertVC = UIAlertController(title: "Sign out", message: Constants.Strings.logoutAlertMessage, preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Sign out", style: .destructive, handler: { (action) in
            self.signOut()
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    private func signOut() {
        try! FUIAuth.defaultAuthUI()?.signOut()
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true, completion: nil)
    }
    
}
