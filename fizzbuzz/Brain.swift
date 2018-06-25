//
//  Brain.swift
//  fizzbuzz
//
//  Created by Jeanette Pranin on 6/20/18.
//  Copyright © 2018 Jeanette Pranin. All rights reserved.
//

import Foundation

class Brain {
    
    func isDivisibleBy(divisor: Int, number: Int) -> Bool {
        return number % divisor == 0
    }
    
    func check(number: Int) -> Move {
        if isDivisibleBy(divisor: 15, number: number) {
            return Move.fizzBuzz
        }
            
        else if isDivisibleBy(divisor: 3, number: number){
            return Move.fizz
        }
            
        else if isDivisibleBy(divisor: 5, number: number) {
            return Move.buzz
        }
        
        return Move.number
        
    }
}
