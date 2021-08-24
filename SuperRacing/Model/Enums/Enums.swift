//
//  Enums.swift
//  PixelRacing
//
//  Created by Артур Кононович on 3.05.21.
//

import Foundation

enum TerrainType: Int, Codable {
    case plain
    case desert
}

enum Speed: Int, Codable {
    case normal
    case fast
}

enum Keys: String {
    case settings
    case scores
}
