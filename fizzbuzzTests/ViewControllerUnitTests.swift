//
//  ViewControllerUnitTests.swift
//  fizzbuzzTests
//
//  Created by Jeanette Pranin on 6/20/18.
//  Copyright © 2018 Jeanette Pranin. All rights reserved.
//

import XCTest
@testable import fizzbuzz

class ViewControllerUnitTests: XCTestCase {
    
    var viewController : ViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        UIApplication.shared.keyWindow!.rootViewController = viewController
        
        let _ = viewController.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMove1IncrementsScore() {
        viewController.play(move: Move.number)
        let newScore = viewController.gameScore
        XCTAssertEqual(newScore, 1)
    }
    
    func testMove2IncrementsScore() {
        viewController.play(move: Move.number)
        viewController.play(move: Move.number)
        let newScore = viewController.gameScore
        XCTAssertEqual(newScore, 2)
    }
    
    func testFizzIncrementsScore() {
        viewController.game?.score = 2
        viewController.play(move: Move.fizz)
        let newScore = viewController.gameScore
        XCTAssertEqual(newScore, 3)
    }
    
    func testBuzzIncrementsScore() {
        viewController.game?.score = 4
        viewController.play(move: Move.buzz)
        let newScore = viewController.gameScore
        XCTAssertEqual(newScore, 5)
    }
    
    func testFizzBuzzIncrementsScore() {
        viewController.game?.score = 14
        viewController.play(move: Move.fizzBuzz)
        let newScore = viewController.gameScore
        XCTAssertEqual(newScore, 15)
    }
    
    func testIncorrectMoveDoesntIncrementsScore() {
        viewController.game?.score = 14
        viewController.play(move: Move.number)
        let newScore = viewController.gameScore
        XCTAssertEqual(newScore, 0)
    }
    
    func testIncorrectMoveDoesntIncrementsScore2() {
        viewController.game?.score = 3
        viewController.play(move: Move.buzz)
        let newScore = viewController.gameScore
        XCTAssertEqual(newScore, 0)
    }
    
    func testHasAGame() {
        XCTAssertNotNil(viewController.game)
    }
    
    
}
