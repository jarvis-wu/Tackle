//
//  Constants.swift
//  Tackle
//
//  Created by Jarvis Wu on 2018-02-06.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import Foundation
import UIKit

enum MenuType: String {
    case more = "More"
}

struct MenuItem {
    var labelName: String
    var leftImageName: String
}

struct Constants {
    
    struct Colors {
        static let tackleYellowLight = UIColor(red: 255/255, green: 218/255, blue: 12/255, alpha: 1)
        static let tackleYellowMid = UIColor(red: 206/255, green: 144/255, blue: 0/255, alpha: 1)
        static let instabugYellow = UIColor(red: 247/255, green: 197/255, blue: 2/255, alpha: 1)
    }
    
    struct UI {
        static let profileImageCornerRadius: CGFloat = 5
        static let meTableViewCellHeight: CGFloat = 45
        static let bigMeTableViewCellHeight: CGFloat = 80
        static let meTableViewSectionHeaderHeight: CGFloat = 20
        static let meTableViewSectionFooterHeight: CGFloat = 0.01
    }
    
    struct Strings {
        static let logoutAlertMessage = "Are you sure that you want to sign out?"
    }
    
    struct Avatars {
        static let avatars = ["corgi", "pelican", "slug-eating", "unicorn"]
    }
    
    struct MenuItemLists {
        static let mainMenuItemList: [[MenuItem]] = [
            [], // profile section uses BigMeTableViewCell instead
            [
                MenuItem(labelName: "Forest", leftImageName: "forest")
            ],
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
        static let secondaryItemLists: [[[[MenuItem]]]] = [
            [
                [[]]    // 0-0 profile
            ],
            [
                [[]]    // 1-0 forest
            ],
            [
                [[]],   // 2-0 events
                [[]],   // 2-1 friends
                [[]]    // 2-2 files
            ],
            [
                [       // 3-0 settings
                    [
                        MenuItem(labelName: "Language", leftImageName: "language"),
                        MenuItem(labelName: "Color & text", leftImageName: "tune")
                    ]
                ],
                [       // 3-1 help
                    [
                        MenuItem(labelName: "User Manual", leftImageName: "user-manual"),
                        MenuItem(labelName: "Send feedbacks", leftImageName: "post"),
                    ]
                ],
                [       // 3-2 more
                    [
                        MenuItem(labelName: "Rate the app", leftImageName: "apple-app-store"),
                        MenuItem(labelName: "Developer", leftImageName: "hammer"),
                        MenuItem(labelName: "About Tackle", leftImageName: "about")
                    ]
                ]
            ],
            [
                [[]]    // 4-0 signout
            ]
        ]
        
    }
    
}
