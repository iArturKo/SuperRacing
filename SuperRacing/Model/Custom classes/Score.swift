//
//  GameResult.swift
//  PixelRacing
//
//  Created by Артур Кононович on 3.05.21.
//

import Foundation

class Score: NSObject, Codable {

    let nickname: String
    let score: Int
    let date: String
    
    init(nickname: String, score: Int, date: String) {
        self.nickname = nickname
        self.score = score
        self.date = date
    }
    
}
