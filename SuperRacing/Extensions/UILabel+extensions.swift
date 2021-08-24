//
//  UILabel+extensions.swift
//  SuperRacing
//
//  Created by Артур Кононович on 23.08.21.
//

import Foundation
import UIKit

extension UILabel {
    func setAttributedText(text: String, size: CGFloat = 70) {
        let font = UIFont(name: "UpheavalPro", size: size)
        let myAttribut: [NSAttributedString.Key: Any] = [ .font: font ?? UIFont.systemFont(ofSize: 50),
                                                          .foregroundColor: UIColor.white,
                                                          .strokeColor: UIColor.darkGray,
                                                          .strokeWidth: -3]
        let attributedString = NSAttributedString(string: text, attributes: myAttribut)
        self.attributedText = attributedString
    }
}
