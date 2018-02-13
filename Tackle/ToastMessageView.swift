//
//  ToastMessageView.swift
//  Tackle
//
//  Created by Jarvis Wu on 2018-02-11.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit

class ToastMessageView: UIView {
    
    @IBOutlet var toastMessageView: UIView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ToastMessageView", owner: self, options: nil)
        addSubview(toastMessageView)
        toastMessageView.frame = self.bounds
        toastMessageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
