//
//  GameManager.swift
//  PixelRacing
//
//  Created by Артур Кононович on 3.05.21.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class GameManager {
    
    static let shared = GameManager()
    
    var scores = BehaviorRelay(value: [Score]())
    var settings = Settings()
    
    let plain = Terrain(road: "road", roadSide: "grass", roadLine: "line", rocks: ["rock", "rock1"], trees: ["smallTree", "smallTree1", "smallTree2", "tree"])
    let desert = Terrain(road: "desertRoad", roadSide: "sand", roadLine: "desertLine", rocks: ["desertRock1", "desertRock2"], trees: ["cactus1", "cactus2", "desertTree1"])
    
    let carImageArray = ["car1", "car2", "car3", "car4",
                         "car5", "car6", "car7", "car8",
                         "car9", "car10",  "car11", "car12",
                         "car13", "car14", "car15"]
    
    private init() {
        if !UserDefaults.wasAppLaunched() {
            UserDefaults.standard.set(encodable: self.settings, forKey: Keys.settings.rawValue)
            UserDefaults.standard.set(encodable: self.scores.value, forKey: Keys.scores.rawValue)
            UserDefaults.setAppWasLaunched()
        } else {
            if let settings = UserDefaults.standard.value(Settings.self, forKey: Keys.settings.rawValue),
               let scores = UserDefaults.standard.value([Score].self, forKey: Keys.scores.rawValue) {
                self.settings = settings
                self.scores.accept(scores)
            }
        }
    }
    
    func setNewNickname(nickName: String) {
        self.settings.nickName = nickName
        UserDefaults.standard.set(encodable: self.settings, forKey: Keys.settings.rawValue)
    }
    
    func setNewSpeed(speed: Speed) {
        self.settings.speed = speed
        UserDefaults.standard.set(encodable: self.settings, forKey: Keys.settings.rawValue)
    }
    
    func setNewTerrain(terrain: TerrainType) {
        self.settings.terrain = terrain
        UserDefaults.standard.set(encodable: self.settings, forKey: Keys.settings.rawValue)
    }
    
    func setNewCar(indexPath: IndexPath) {
        self.settings.carImageName = self.carImageArray[indexPath.row]
        UserDefaults.standard.set(encodable: self.settings, forKey: Keys.settings.rawValue)
    }
    
    func getCurrentIndexPath() -> IndexPath {
        if let index = self.carImageArray.firstIndex(of: self.settings.carImageName) {
            return IndexPath(row: index, section: 0)
        }
        return IndexPath(row: 0, section: 0)
    }
    
    func getRandomCarImage() -> UIImage {
        if let image = UIImage(named: self.carImageArray[Int.random(in: 0...self.carImageArray.count - 1)]) {
            return image
        }
        return UIImage()
    }
    
    func addNewScore(score: Int) {
        let gameResult = Score(nickname: settings.nickName, score: score, date: self.getCurrentDate())
        
        
        
        var scores = self.scores.value
        scores.append(gameResult)
        scores.sort(by: {$0.score > $1.score })
        if scores.count > 10 {
            scores.removeLast()
        }
        self.scores.accept(scores)
        
        UserDefaults.standard.set(encodable: self.scores.value, forKey: Keys.scores.rawValue)
    }
    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        let date = formatter.string(from: Date())
        return date
    }
    
    func getTerrain() -> Terrain {
        switch self.settings.terrain {
        case .plain:
            return self.plain
        case .desert:
            return self.desert
        }
    }
    
}
