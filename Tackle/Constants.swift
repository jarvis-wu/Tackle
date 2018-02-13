//
//  Constants.swift
//  Tackle
//
//  Created by Jarvis Wu on 2018-02-06.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Colors {
        static let tackleYellowLight = UIColor(red: 255/255, green: 218/255, blue: 12/255, alpha: 1)
        static let tackleYellowMid = UIColor(red: 206/255, green: 144/255, blue: 0/255, alpha: 1)
        static let instabugYellow = UIColor(red: 247/255, green: 197/255, blue: 2/255, alpha: 1)
        static let toastGreen = UIColor(red: 29/255, green: 185/255, blue: 84/255, alpha: 1)
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
        static let saveQRCodeAlertMessage = "Do you want to save your QR code to camera roll?"
    }
    
    struct Avatars {
        static let avatars = ["alligator", "beaver", "corgi", "kangaroo", "panda", "pelican", "sloth", "slug-eating", "unicorn"]
    }
    
    struct MenuItemLists {
        static let mainMenuItemList: [[MenuItem]] = [
            [], // profile section uses BigMeTableViewCell instead
            [
                MenuItem(labelName: "Forest", leftImageName: "forest")
            ],
            [
                MenuItem(labelName: "Tackles", leftImageName: "suitcase"),
                MenuItem(labelName: "Agenda", leftImageName: "calendar"),
                MenuItem(labelName: "Friends", leftImageName: "contacts"),
                MenuItem(labelName: "Notes", leftImageName: "note")
            ],
            [
                MenuItem(labelName: "Settings", leftImageName: "gears"),
                MenuItem(labelName: "More", leftImageName: "more")
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
                [[]],   // 2-0 projects
                [[]],   // 2-1 agenda
                [[]],   // 2-2 friends
                [[]]    // 2-3 notes
            ],
            [
                [       // 3-0 settings
                    [
                        MenuItem(labelName: "Language", leftImageName: "language")
                    ],
                    [
                        MenuItem(labelName: "Color & text", leftImageName: "tune")
                    ],
                    [
                        MenuItem(labelName: "Instabug", leftImageName: "bug")
                    ],
                    [
                        MenuItem(labelName: "Sign out", leftImageName: "shutdown")
                    ]
                ],
                [       // 3-1 more
                    [
                        MenuItem(labelName: "Get help", leftImageName: "user-manual"),
                    ],
                    [
                        MenuItem(labelName: "Rate the app", leftImageName: "apple-app-store"),
                        MenuItem(labelName: "Send feedbacks", leftImageName: "post")
                    ],
                    [
                        MenuItem(labelName: "Developer", leftImageName: "hammer"),
                        MenuItem(labelName: "About Tackle", leftImageName: "about")
                    ]
                ]
            ]
        ]
        
    }
    
    struct UserDefaultsKeys {
        static let InstabugIsOn = "instabug"
        static let CurrentUserMetadata = "currrentUserMetadata"
    }
    
}
