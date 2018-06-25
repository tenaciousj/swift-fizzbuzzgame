//
//  Game.swift
//  fizzbuzz
//
//  Created by Jeanette Pranin on 6/20/18.
//  Copyright © 2018 Jeanette Pranin. All rights reserved.
//

import Foundation

class Game {
    
    var score: Int
    var brain: Brain
    
    init() {
        score = 0
        brain = Brain()
    }
    
    func play(move: Move) -> (right: Bool, score: Int) {
        let result = brain.check(number: score + 1)
        
        if result == move {
            score += 1
            return (true, score)
        }
        return (false, score)
    }
    
    func restartGame() {
        score = 0
    }
    
}
