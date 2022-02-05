//
//  Model.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/4/22.
//

import Foundation

enum Games: String, CaseIterable {
    case oneDigitHex2Decimal
}
class Model: ObservableObject {
    @Published var gameScore: [String:GameScore] = [:]
    
    init() {
        for game in Games.allCases {
            if gameScore[game.rawValue] == nil {
                let newGameScore = GameScore()
                gameScore[game.rawValue] = newGameScore
            }
        }
    }
}


class GameScore: ObservableObject {
    @Published private(set) var correctTotal = 0
    @Published private(set) var wrongTotal = 0
    
    @Published private(set) var last100: [Bool] = []
    
    var last100correct: Int {
        last100.reduce(0) {$0 + ($1 ? 1 : 0)}
    }
    var last100wrong: Int {
        last100.reduce(0) {$0 + ($1 ? 0 : 1)}
    }
    
    
    func correct() {
        correctTotal += 1
        last100.insert(true, at:0)
        if last100.count > 100 {
            last100.removeLast()
        }
    }
    
    func wrong() {
        wrongTotal += 1
        last100.insert(false, at: 0)
        if last100.count > 100 {
            last100.removeLast()
        }
    }
    
}
