//
//  String+extensions.swift
//  SuperRacing
//
//  Created by Артур Кононович on 23.08.21.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
