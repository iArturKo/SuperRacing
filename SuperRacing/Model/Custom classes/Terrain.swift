//
//  Terrain.swift
//  SuperRacing
//
//  Created by Артур Кононович on 21.08.21.
//

import Foundation
import UIKit

class Terrain {
    
    var road = UIImage()
    var roadSide = UIImage()
    var roadLine = UIImage()
    var rocks = [UIImage]()
    var trees = [UIImage]()
    
    init() {
        
    }
    
    init(road: String, roadSide: String, roadLine: String, rocks: [String], trees: [String]) {
        if let roadImage = UIImage(named: road) {
            self.road = roadImage
        }
        if let roadSideImage = UIImage(named: roadSide) {
            self.roadSide = roadSideImage
        }
        if let roadLine = UIImage(named: roadLine) {
            self.roadLine = roadLine
        }
        for rock in rocks {
            if let rockImage = UIImage(named: rock) {
                self.rocks.append(rockImage)
            }
        }
        for tree in trees {
            if let treeImage = UIImage(named: tree) {
                self.trees.append(treeImage)
            }
        }
    }
    
}
