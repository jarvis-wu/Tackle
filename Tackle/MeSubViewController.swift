//
//  MeSubViewController.swift
//  Tackle
//
//  Created by Jarvis Wu on 2018-02-07.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit

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
        if sourceIndexPath == IndexPath(row: 0, section: 3) && indexPath == IndexPath(row: 0, section: 2) { // instabug switch
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
    
}
