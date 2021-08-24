//
//  UIView+extensions.swift
//  PixelRacing
//
//  Created by Артур Кононович on 19.04.21.
//

import UIKit
import Foundation

extension UIView {
    func roundCorners(radius: CGFloat = 5) {
        self.layer.cornerRadius = radius
    }
    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = false
    }
    
    func customizeButton() {
        backgroundColor = .orange
        layer.borderWidth = 3
        layer.borderColor = UIColor.yellow.cgColor
    }
}
