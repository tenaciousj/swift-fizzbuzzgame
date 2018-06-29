//
//  ViewControllerUITests.swift
//  fizzbuzzUITests
//
//  Created by Jeanette Pranin on 6/21/18.
//  Copyright © 2018 Jeanette Pranin. All rights reserved.
//

import XCTest

class ViewControllerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTapNumberButtonIncrementsScore() {
        let app = XCUIApplication()
        let numberButton = app.buttons["numberButton"]
        
        numberButton.tap()
        let newScore = numberButton.label
        XCTAssertEqual(newScore, "1")
        
    }
    
    func testDoubleTapNumberButtonIncrementsScore() {
        let app = XCUIApplication()
        let numberButton = app.buttons["numberButton"]
        
        numberButton.tap()
        numberButton.tap()
        let newScore = numberButton.label
        XCTAssertEqual(newScore, "2")
        
    }
    
    func testTapFizzButton() {
        let app = XCUIApplication()
        let numberButton = app.buttons["numberButton"]
        let fizzButton = app.buttons["fizzButton"]
        
        numberButton.tap()
        numberButton.tap()
        fizzButton.tap()
        let newScore = numberButton.label
        XCTAssertEqual(newScore, "3")
        
    
    }
    
    func testTapBuzzButton() {
        let app = XCUIApplication()
        let numberButton = app.buttons["numberButton"]
        let fizzButton = app.buttons["fizzButton"]
        let buzzButton = app.buttons["buzzButton"]
        
        
        numberButton.tap()
        numberButton.tap()
        fizzButton.tap()
        numberButton.tap()
        buzzButton.tap()
        let newScore = numberButton.label
        XCTAssertEqual(newScore, "5")
        
        
    }
    
    func playTo14() {
        let app = XCUIApplication()
        let numberButton = app.buttons["numberButton"]
        let fizzButton = app.buttons["fizzButton"]
        let buzzButton = app.buttons["buzzButton"]
        
        numberButton.tap()
        numberButton.tap()
        fizzButton.tap()
        numberButton.tap()
        buzzButton.tap()
        fizzButton.tap()
        numberButton.tap()
        numberButton.tap()
        fizzButton.tap()
        buzzButton.tap()
        numberButton.tap()
        fizzButton.tap()
        numberButton.tap()
        numberButton.tap()
    }
    
    func testTapFizzBuzzButton() {
        let app = XCUIApplication()
        let numberButton = app.buttons["numberButton"]
        let fizzBuzzButton = app.buttons["fizzBuzzButton"]
        
        playTo14()
        
        fizzBuzzButton.tap()
        let newScore = numberButton.label
        XCTAssertEqual(newScore, "15")
        
    }
    
    func testWrongValueCreatesAlert() {
        let app = XCUIApplication()
        let numberButton = app.buttons["numberButton"]
        
        numberButton.tap()
        numberButton.tap()
        numberButton.tap()
        
        let wrongalert = app.alerts["Wrong!"]
        XCTAssertTrue(wrongalert.exists)
        XCTAssertTrue(wrongalert.isHittable)
        XCTAssertTrue(wrongalert.buttons["OK"].exists)
        XCTAssertTrue(wrongalert.buttons["OK"].isHittable)
    }
    
    func testRightValueDoesNotCreateAlert() {
        let app = XCUIApplication()
        let numberButton = app.buttons["numberButton"]
        
        numberButton.tap()
        numberButton.tap()
        let wrongalert = app.alerts["Wrong!"]
        XCTAssertFalse(wrongalert.exists)
    }
    
    func testTimerLabelStarts() {
        let app = XCUIApplication()
        let timerLabel = app/*@START_MENU_TOKEN@*/.staticTexts["timerLabel"]/*[[".staticTexts[\"00:00\"]",".staticTexts[\"timerLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let numberButton = app.buttons["numberButton"]
        XCTAssertEqual(timerLabel.label, "00:00")
        numberButton.tap()
        numberButton.tap()
        XCTAssertNotEqual(timerLabel.label, "00:00")
        
    }
    
    func testWrongAnswerResetsTimerLabel() {
        let app = XCUIApplication()
        let timerLabel = app/*@START_MENU_TOKEN@*/.staticTexts["timerLabel"]/*[[".staticTexts[\"00:00\"]",".staticTexts[\"timerLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let numberButton = app.buttons["numberButton"]
        XCTAssertEqual(timerLabel.label, "00:00")
        numberButton.tap()
        numberButton.tap()
        numberButton.tap()
        let wrongalert = app.alerts["Wrong!"]
        XCTAssertTrue(wrongalert.exists)
        XCTAssertTrue(wrongalert.isHittable)
        XCTAssertTrue(wrongalert.buttons["OK"].exists)
        XCTAssertTrue(wrongalert.buttons["OK"].isHittable)
        wrongalert.buttons["OK"].tap()
        XCTAssertEqual(timerLabel.label, "00:00")
        
    }
}
