//
//  BrainTests.swift
//  fizzbuzzTests
//
//  Created by Jeanette Pranin on 6/20/18.
//  Copyright © 2018 Jeanette Pranin. All rights reserved.
//

import XCTest
@testable import fizzbuzz

class BrainTests: XCTestCase {
    
    let brain = Brain()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIsDivisibleByThree_1() {
        let result = brain.isDivisibleBy(divisor: 3, number: 3)
        XCTAssertTrue(result)
    }
    
    func testIsDivisibleByThree_2() {
        let result = brain.isDivisibleBy(divisor: 3, number: 5)
        XCTAssertFalse(result)
    }
    
    func testIsDivisibleByFive_1() {
        let result = brain.isDivisibleBy(divisor: 5, number: 10)
        XCTAssertTrue(result)
    }
    
    func testIsDivisibleByFive_2() {
        let result = brain.isDivisibleBy(divisor: 5, number: 13)
        XCTAssertFalse(result)
    }
    
    func testIsDivisibleByFifteen_1() {
        let result = brain.isDivisibleBy(divisor: 15, number: 30)
        XCTAssertTrue(result)
    }
    
    func testIsDivisibleByFifteen_2() {
        let result = brain.isDivisibleBy(divisor: 15, number: 42)
        XCTAssertFalse(result)
    }
    
    func testSayFizz() {
        let result = brain.check(number: 3)
        XCTAssertEqual(result, Move.fizz)
    }
    
    func testSayBuzz() {
        let result = brain.check(number: 5)
        XCTAssertEqual(result, Move.buzz)
    }
    
    func testSayFizzBuzz() {
        let result = brain.check(number: 15)
        XCTAssertEqual(result, Move.fizzBuzz)
    }
    
    func testSayNumber() {
        let result = brain.check(number: 1)
        XCTAssertEqual(result, Move.number)
    }
}
