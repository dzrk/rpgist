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
    
    func testAddButton() {
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars.buttons["Quest"].tap()
        app.buttons["+"].tap()
        app.textFields["New category name"].typeText("Test")
        app.buttons["Add"].tap()
        
//        let myTable = app.tables.matching(identifier: "FirstViewTable")
//        let cell = myTable.cells.element(matching: .cell, identifier: "FirstViewCell_3")
//        print(cell.label)
//        print(myTable.cells.debugDescription)
//        XCTAssert(cell.identifier == "FirstViewCell_3")
    }
}
