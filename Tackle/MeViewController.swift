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
    
    private let menuItemList = Constants.MenuItemLists.mainMenuItemList
    
    private var destinationIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        addNavBarButton()
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
        return menuItemList.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 1
        if section != 0 {
            numberOfRows = menuItemList[section].count
        }
        return numberOfRows
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var resultCell = UITableViewCell()
        if indexPath.section != 0 {
            let cell = Bundle.main.loadNibNamed("MeTableViewCell", owner: self, options: nil)?.first as! MeTableViewCell
            cell.label.text = menuItemList[indexPath.section][indexPath.row].labelName
            cell.leftImageView.image = UIImage(named: menuItemList[indexPath.section][indexPath.row].leftImageName)
            resultCell = cell
        } else {
            let cell = Bundle.main.loadNibNamed("BigMeTableViewCell", owner: self, options: nil)?.first as! BigMeTableViewCell
            cell.leftImageView.image = UIImage(named: getRandomAvatar())
            cell.leftImageView.layer.cornerRadius = Constants.UI.profileImageCornerRadius
            cell.leftImageView.layer.masksToBounds = true
            cell.topLabel.text = Auth.auth().currentUser?.displayName
            cell.bottomLabel.text = Auth.auth().currentUser?.email
            cell.middleImageView.image = UIImage(named: "edit-gray")
            resultCell = cell
        }
        return resultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let numOfSections = numberOfSections(in: tableView)
        if indexPath.section == numOfSections - 1 {
            if indexPath.row == tableView.numberOfRows(inSection: numOfSections - 1) - 1 {
                showSignOutAlert()
            }
        } else if indexPath.section != 0 {
            destinationIndexPath = indexPath
            performSegue(withIdentifier: "goToSecondary", sender: self)
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
        let vc = segue.destination as! MeSubViewController
        vc.sourceIndexPath = destinationIndexPath
        let cell = tableView.cellForRow(at: destinationIndexPath) as! MeTableViewCell
        vc.title = cell.label.text
    }
    
    private func getRandomAvatar() -> String {
        let avatars = Constants.Avatars.avatars
        let randomIndex = Int(arc4random_uniform(UInt32(avatars.count)))
        return avatars[randomIndex]
    }
    
    private func addNavBarButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "qr-code"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(self.navBarButtonPressed), for: UIControlEvents.touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        button.contentMode = .scaleAspectFit
       self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func navBarButtonPressed() {
        print("Nav bar button pressed")
    }

}

