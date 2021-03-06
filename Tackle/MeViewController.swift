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
    
    public var isPresentingQRCodeViewController = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addReachabilityObserver()
        tableView.delegate = self
        tableView.dataSource = self
        addQRCodeBarButton()
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
            let userMetadata = TackleManager.shared.getSetting(withKey: Constants.UserDefaultsKeys.CurrentUserMetadata) as! UserMetadata
            cell.leftImageView.image = UIImage(named: userMetadata.userAvatarName)
            cell.leftImageView.layer.cornerRadius = Constants.UI.profileImageCornerRadius
            cell.leftImageView.layer.masksToBounds = true
            cell.topLabel.text = userMetadata.userName
            cell.bottomLabel.text = userMetadata.userEmail
            cell.middleImageView.image = UIImage(named: "edit-gray")
            resultCell = cell
        }
        return resultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section != 0 {
            destinationIndexPath = indexPath
            performSegue(withIdentifier: "goToSecondary", sender: self)
        } else {
            performSegue(withIdentifier: "goToProfile", sender: self)
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
        if segue.identifier == "goToSecondary" {
            let vc = segue.destination as! MeSubViewController
            vc.sourceIndexPath = destinationIndexPath
            let cell = tableView.cellForRow(at: destinationIndexPath) as! MeTableViewCell
            vc.title = cell.label.text
        } else if segue.identifier == "goToProfile" {
            let vc = segue.destination
            vc.title = "Profile"
        }
    }
    
    public func addQRCodeBarButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "qr-code"), for: .normal)
        button.addTarget(self, action: #selector(self.qrCodeBarButtonPressed), for: UIControlEvents.touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        button.contentMode = .scaleAspectFit
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: button)]
    }
    
    private func addSaveImageBarButton() {
        self.navigationItem.rightBarButtonItems?.removeAll()
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "download"), for: .normal)
        button.addTarget(self, action: #selector(self.saveImageBarButtonPressed), for: UIControlEvents.touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        button.contentMode = .scaleAspectFit
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: button)]
    }
    
    @objc func qrCodeBarButtonPressed() {
        addSaveImageBarButton()
        self.isPresentingQRCodeViewController = true
        let popvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QRCodeViewController") as! QRCodeViewController
        popvc.view.frame = self.tableView.frame
        self.addChildViewController(popvc)
        self.view.addSubview(popvc.view)
        popvc.didMove(toParentViewController: self)
    }
    
    @objc func saveImageBarButtonPressed() {
        showSaveImageAlert()
    }
    
    private func showSaveImageAlert() {
        let alertVC = UIAlertController(title: "Save QR code", message: Constants.Strings.saveQRCodeAlertMessage, preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            if let qrCodeViewController = self.childViewControllers[0] as? QRCodeViewController {
                qrCodeViewController.saveImage()
            }
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    private func addReachabilityObserver() {
        if TackleManager.shared.isOffline {
            TackleManager.shared.shouldShowOfflineMessage(fromViewController: self)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(networkStateHasChanged), name: NSNotification.Name(rawValue: "networkStateHasChanged"), object: nil)
    }
    
    @objc func networkStateHasChanged() {
        if TackleManager.shared.isOffline {
            TackleManager.shared.shouldShowOfflineMessage(fromViewController: self)
        } else {
            TackleManager.shared.shouldShowOnlineMessage(fromViewController: self)
        }
    }

}

