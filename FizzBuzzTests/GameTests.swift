//
//  GameTests.swift
//  fizzbuzzTests
//
//  Created by Jeanette Pranin on 6/20/18.
//  Copyright © 2018 Jeanette Pranin. All rights reserved.
//

import XCTest
@testable import fizzbuzz

class GameTests: XCTestCase {
    
    let game = Game()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGameStartsAtZero() {
        XCTAssertTrue(game.score == 0)
    }
    
    func testOnPlayScoreIncremented_1() {
        game.score = 1
        let _ = game.play(move: Move.number)
        XCTAssertTrue(game.score == 2)
    }
    
    func testOnPlayScoreIncremented_2() {
        game.score = 1
        let _ = game.play(move: Move.number)
        XCTAssertTrue(game.score == 2)
    }
    
    func testIfMoveIsRight_Fizz() {
        game.score = 2
        let result = game.play(move: Move.fizz)
        XCTAssertTrue(result.right)
    }
    
    func testIfMoveIsWrong_Fizz() {
        game.score = 1
        let result = game.play(move: Move.fizz)
        XCTAssertFalse(result.right)
    }
    
    func testIfMoveIsRight_Buzz() {
        game.score = 4
        let result = game.play(move: Move.buzz)
        XCTAssertTrue(result.right)
    }
    
    func testIfMoveIsWrong_Buzz() {
        game.score = 6
        let result = game.play(move: Move.buzz)
        XCTAssertFalse(result.right)
    }
    
    func testIfMoveIsRight_FizzBuzz() {
        game.score = 14
        let result = game.play(move: Move.fizzBuzz)
        XCTAssertTrue(result.right)
    }
    
    func testIfMoveIsWrong_FizzBuzz() {
        game.score = 20
        let result = game.play(move: Move.fizzBuzz)
        XCTAssertFalse(result.right)
    }
    
    func testIfMoveIsRight_Number() {
        game.score = 13
        let result = game.play(move: Move.number)
        XCTAssertTrue(result.right)
    }
    
    func testIfMoveIsWrong_Number() {
        game.score = 14
        let result = game.play(move: Move.number)
        XCTAssertFalse(result.right)
    }
    
    func testIfMoveWrongScoreNotIncremented() {
        game.score = 1
        let _ = game.play(move: Move.fizz)
        XCTAssertEqual(game.score, 1)
    }
    
    func testPlayShouldReturnIfMoveRight() {
        let response = game.play(move: Move.number)
        XCTAssertNotNil(response.right)
    }
    
    func testPlayShouldReturnNewScore() {
        let response = game.play(move: Move.number)
        XCTAssertNotNil(response.score)
    }
}
