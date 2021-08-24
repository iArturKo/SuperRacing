//
//  Settings.swift
//  PixelRacing
//
//  Created by Артур Кононович on 3.05.21.
//

import Foundation

class Settings: NSObject, Codable {
    
    var nickName: String
    var carImageName: String
    var terrain: TerrainType
    var speed: Speed
    
    init(nickName: String = "Player", carImageName: String = "car1", terrain: TerrainType = .plain, speed: Speed = .normal) {
        self.nickName = nickName
        self.carImageName = carImageName
        self.terrain = terrain
        self.speed = speed
    }

    public enum CodingKeys: String, CodingKey {
        case nickName, carImageName, terrain, speed
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.nickName, forKey: .nickName)
        try container.encode(self.carImageName, forKey: .carImageName)
        try container.encode(self.terrain, forKey: .terrain)
        try container.encode(self.speed, forKey: .speed)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.nickName = try container.decode(String.self, forKey: .nickName)
        self.carImageName = try container.decode(String.self, forKey: .carImageName)
        self.terrain = try container.decode(TerrainType.self, forKey: .terrain)
        self.speed = try container.decode(Speed.self, forKey: .speed)
    }
    
}
