//
//  Extensions.swift
//  Tackle
//
//  Created by Jarvis Wu on 2018-02-13.
//  Copyright © 2018 Jarvis Zhaowei Wu. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func resize(scaledToSize newSize: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
