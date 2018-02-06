//
//  BigMeTableViewCell.swift
//  Tackle
//
//  Created by Jarvis Wu on 2018-02-06.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit

class BigMeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var bottomLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
