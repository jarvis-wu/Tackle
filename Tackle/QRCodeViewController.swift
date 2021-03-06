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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        appearAnimate()
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
        let userMetadata = TackleManager.shared.getSetting(withKey: Constants.UserDefaultsKeys.CurrentUserMetadata) as! UserMetadata
        avatarTopLabel.text = userMetadata.userName
        avatarBottomLabel.text = userMetadata.userEmail
        avatarImageView.image = UIImage(named: userMetadata.userAvatarName)
        avatarImageView.layer.cornerRadius = Constants.UI.profileImageCornerRadius
        avatarImageView.layer.masksToBounds = true
        dismissButton.setTitle("OK", for: .normal)
        dismissButton.backgroundColor = UIColor.white
        dismissButton.setTitleColor(Constants.Colors.tackleDarkGray, for: .normal)
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
        let view = self.backgroundView
        view?.layer.cornerRadius = 0
        let image = imageWithView(inView: view!)
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        // TODO: can we get higher resolution?
        // TODO: add a toast to confirm that photo have been saved
    }
    
    private func imageWithView(inView: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(inView.bounds.size, inView.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            inView.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }

}
