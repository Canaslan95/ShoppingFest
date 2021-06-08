//
//  UIView+Extensions.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 3.06.2021.
//

import Foundation
import UIKit

extension UIView {
    
    func dropShadow(width: CGFloat, height: CGFloat) {
        let size: CGFloat = 20
        let distance: CGFloat = 0
        let rect = CGRect(
            x: -size,
            y: height - (size * 0.4) + distance,
            width: width + size * 2,
            height: size
        )
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.5
        layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
    }
    
}
