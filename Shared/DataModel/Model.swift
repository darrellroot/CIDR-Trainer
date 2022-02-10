//
//  Model.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/4/22.
//

import Foundation


/*class Model: ObservableObject {
    @Published private(set) var gameScore: [String:GameScore] = [:]
    
    init() {
        for game in Games.allCases {
            if gameScore[game.rawValue] == nil {
                let newGameScore = GameScore(name: game.rawValue)
                gameScore[game.rawValue] = newGameScore
            }
        }
    }
}*/


/*class GameScore: ObservableObject {
    static let lastSize = 10
    
    let gameName: String
    @Published private(set) var correctTotal = 0
    @Published private(set) var wrongTotal = 0
    
    @Published private(set) var last100: [Bool] = []
    var nextPosition: Int = 0 // next position in last100 round robin array
    
    init(name: String) {
        self.gameName = name
    }
    
    var last100correct: Int {
        last100.reduce(0) {$0 + ($1 ? 1 : 0)}
    }
    var last100wrong: Int {
        last100.reduce(0) {$0 + ($1 ? 0 : 1)}
    }
    
    
    func correct() {
        correctTotal += 1
        
        // should not get here but just in case
        if nextPosition >= GameScore.lastSize {
            nextPosition = 0
        }
        if nextPosition >= last100.count {
            last100.append(true)
        } else {
            last100[nextPosition] = true
        }
        nextPosition += 1
        if nextPosition >= GameScore.lastSize {
            nextPosition = 0
        }
    }
    
    func wrong() {
        wrongTotal += 1
        // should not get here but just in case
        if nextPosition >= GameScore.lastSize {
            nextPosition = 0
        }

        if nextPosition >= last100.count {
            last100.append(false)
        } else {
            last100[nextPosition] = false
        }
        nextPosition += 1
        if nextPosition >= GameScore.lastSize {
            nextPosition = 0
        }
    }
    
}*/
