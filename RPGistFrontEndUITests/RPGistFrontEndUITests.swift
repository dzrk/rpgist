//
//  RPGistFrontEndUITests.swift
//  RPGistFrontEndUITests
//
//  Created by Priscilla Jofani Oetomo on 9/14/17.
//  Copyright © 2017 Priscilla Jofani Oetomo. All rights reserved.
//
import UIKit
import XCTest

class RPGistFrontEndUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        print(XCUIApplication().debugDescription)
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testExample() {
//        // Use recording to get started writing UI tests.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
    
    func testTabs() {
        let app = XCUIApplication()
        app.launch()
        
        let tabNames = ["Hero", "Quest", "Rewards"]
        
        for _ in 0 ..< 10 {
            app.tabBars.buttons[tabNames[Int(arc4random_uniform(3))]].tap()
        }
    }
    
    func testQuestTab() {
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars.buttons["Quest"].tap()
        app.buttons["+"].tap()
        app.textFields["New category name"].typeText("Test1")
        app.buttons["Cancel"].tap()
        app.buttons["+"].tap()
        app.textFields["New category name"].typeText("Test2")
        app.buttons["Add"].tap()
        
        var myTable = app.tables.matching(identifier: "FirstViewTable")
        var cell = myTable.cells.element(matching: .cell, identifier: "FirstViewCell_\(Int(arc4random_uniform(3)))")
        cell.tap()
        
        app.buttons["+"].tap()
        app.textFields["New task name"].typeText("Test3")
        app.buttons["Cancel"].tap()
        app.buttons["+"].tap()
        app.textFields["New task name"].typeText("Test4")
        app.buttons["Add"].tap()
        
        myTable = app.tables.matching(identifier: "TasksTable")
        cell = myTable.cells.element(matching: .cell, identifier: "TasksCell_\(Int(arc4random_uniform(2)))")
        cell.tap()
        
        app.buttons.element(matching: .button, identifier: "expBtn").tap()
        app.sliders.element(matching: .slider, identifier: "sliderDiff").adjust(toNormalizedSliderPosition: 0.93)
        app.sliders.element(matching: .slider, identifier: "sliderImp").adjust(toNormalizedSliderPosition: 0.45)
        app.sliders.element(matching: .slider, identifier: "sliderImp").adjust(toNormalizedSliderPosition: 0.67)
        app.sliders.element(matching: .slider, identifier: "sliderDiff").adjust(toNormalizedSliderPosition: 0.21)
        app.buttons["Cancel"].tap()
        
        app.buttons.element(matching: .button, identifier: "expBtn").tap()
        app.sliders.element(matching: .slider, identifier: "sliderImp").adjust(toNormalizedSliderPosition: 0.53)
        app.sliders.element(matching: .slider, identifier: "sliderImp").adjust(toNormalizedSliderPosition: 0.39)
        app.sliders.element(matching: .slider, identifier: "sliderDiff").adjust(toNormalizedSliderPosition: 0.26)
        app.sliders.element(matching: .slider, identifier: "sliderImp").adjust(toNormalizedSliderPosition: 0.87)
        app.buttons["Save"].tap()
        
        app.buttons.element(matching: .button, identifier: "goldBtn").tap()
        app.buttons["OK"].tap()
        
        app.buttons.element(matching: .button, identifier: "notesBtn").tap()
        app.textViews.element(matching: .textView, identifier: "notes").tap()
        app.textViews.element(matching: .textView, identifier: "notes").typeText("Hello")
        app.buttons["Cancel"].tap()
        app.buttons.element(matching: .button, identifier: "notesBtn").tap()
        app.textViews.element(matching: .textView, identifier: "notes").tap()
        app.textViews.element(matching: .textView, identifier: "notes").typeText("Hello")
        app.buttons["Save"].tap()
        
        app.buttons.element(matching: .button, identifier: "dueBtn").tap()
        app.buttons["Cancel"].tap()
        app.buttons.element(matching: .button, identifier: "dueBtn").tap()
        app.buttons["Save"].tap()
        
//        print(cell.label)
//        print(myTable.cells.debugDescription)
//        XCTAssert(cell.identifier == "FirstViewCell_3")
    }
    
//    func testLogin() {
//        let app = XCUIApplication()
//        app.launch()
//        
//        app.buttons["Login"].tap()
//        app.buttons["Cancel"].tap()
//        
//        app.buttons["Login"].tap()
//        app.textFields["email"].typeText("theNewEmail")
//        app.textFields.element(matching: .textField, identifier: "password").tap()
//        app.textFields["password"].typeText("theNewPassword")
//        app.buttons["Sign up"].tap()
//        
//        app.buttons["Login"].tap()
//        app.textFields["email"].typeText("theWrongEmail")
//        app.textFields.element(matching: .textField, identifier: "password").tap()
//        app.textFields["password"].typeText("theWrongPassword")
//        app.buttons["Sign in"].tap()
//        
//        app.buttons["Login"].tap()
//        app.textFields["email"].typeText("theCorrectEmail")
//        app.textFields.element(matching: .textField, identifier: "password").tap()
//        app.textFields["password"].typeText("theCorrectPassword")
//        app.buttons["Sign in"].tap()
//    }

    /*
    func testRewards() {
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars.buttons["Rewards"].tap()
        
        var myTable = app.tables.matching(identifier: "RewardsTable")
        var tableCell = myTable.cells.element(matching: .cell, identifier: "RewardsTableCell_0")
        var myCollection = tableCell.collectionViews.matching(identifier: "RewardsCollection")
        var collectionCell = myCollection.element(matching: .cell, identifier: "RewardsCollectionCell_1")
        
        collectionCell.tap()
        
    }
    */
}
