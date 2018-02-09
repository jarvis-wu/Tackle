//
//  QRCodeViewController.swift
//  Tackle
//
//  Created by Jarvis Wu on 2018-02-08.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var avatarTopLabel: UILabel!
    
    @IBOutlet weak var avatarBottomLabel: UILabel!
    
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    var avatarImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        appearAnimate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avatarImageView.image = avatarImage
    }
    
    @IBAction func didTapDismissButton(_ sender: Any) {
        if let parent = self.parent as? MeViewController {
            parent.navigationItem.rightBarButtonItems?.removeAll()
            parent.addQRCodeBarButton()
            parent.isPresentingQRCodeViewController = false
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(translationX: 0, y: 500)
            self.view.alpha = 0
        }, completion: {(finished : Bool) in
            if finished {
                self.willMove(toParentViewController: nil)
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
            }
        })
    }
    
    private func configureUI() {
        self.view.backgroundColor = UIColor.clear
        backgroundView.layer.cornerRadius = 15
        qrCodeImageView.image = UIImage(named: "sample-qr")
        avatarImageView.layer.cornerRadius = Constants.UI.profileImageCornerRadius
        avatarImageView.layer.masksToBounds = true
        dismissButton.setTitle("OK", for: .normal)
        dismissButton.backgroundColor = Constants.Colors.tackleYellowLight
        dismissButton.setTitleColor(Constants.Colors.tackleYellowMid, for: .normal)
        dismissButton.layer.cornerRadius = 15
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.5
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 0)
    }
    
    private func appearAnimate() {
        self.view.transform = CGAffineTransform(translationX: 0, y: 500)
        self.view.alpha = 0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    
    public func saveImage() {
        UIImageWriteToSavedPhotosAlbum(qrCodeImageView.image!, nil, nil, nil)
        // TODO: can we get higher resolution?
        // TODO: add a toast to confirm that photo have been saved
    }

}
