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
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app.launch()
        
        //print(XCUIApplication().debugDescription)
    }
    
    func testTabs() {
        let app = XCUIApplication()
        app.launch()
        
        let tabNames = ["Hero", "Quest", "Rewards"]
        
        for _ in 0 ..< 10 {
            app.tabBars.buttons[tabNames[Int(arc4random_uniform(3))]].tap()
        }
    }
    
    func testQuestTab() {
        //Making sure we are at the correct tab
        app.tabBars.buttons["Quest"].tap()
        
        //Try adding a new category
        app.buttons["+"].tap()
        app.textFields["New category name"].typeText("Test1")
        app.buttons["Cancel"].tap() //Testing the cancel button
        
        //Try adding a new category
        app.buttons["+"].tap()
        app.textFields["New category name"].typeText("Test2")
        app.buttons["Add"].tap() //Testing the add button
        
        //Initialize the category table and cells to be tapped
        var myTable = app.tables.matching(identifier: "FirstViewTable")
        var cell = myTable.cells.element(matching: .cell, identifier: "FirstViewCell_\(Int(arc4random_uniform(3)))") //selecting a random cell
        
        cell.swipeLeft()
        cell.buttons["Delete"].tap()
        
        cell = myTable.cells.element(matching: .cell, identifier: "FirstViewCell_\(Int(arc4random_uniform(3)))") //selecting a random cell
        cell.tap()
        cell.tap()
        
        //Try adding a new task
        app.buttons["+"].tap()
        app.textFields["New task name"].typeText("Test3")
        app.buttons["Cancel"].tap() //Testing the cancel button
        
        //Try adding a new task
        app.buttons["+"].tap()
        app.textFields["New task name"].typeText("Test4")
        app.buttons["Add"].tap() //Testing the add button
        
        //Initialize the task table and cells to be tapped
        myTable = app.tables.matching(identifier: "TasksTable")
        cell = myTable.cells.element(matching: .cell, identifier: "TasksCell_\(Int(arc4random_uniform(2)))") //selecting a random cell
        
        cell.swipeLeft()
        cell.buttons["Delete"].tap()
        
        cell = myTable.cells.element(matching: .cell, identifier: "TasksCell_\(Int(arc4random_uniform(2)))") //selecting a random cell
        cell.tap()
        cell.tap()
        
        //Testing the exp popup view: sliders and cancel button
        app.buttons.element(matching: .button, identifier: "expBtn").tap()
        app.sliders.element(matching: .slider, identifier: "sliderDiff").adjust(toNormalizedSliderPosition: 0.93)
        app.sliders.element(matching: .slider, identifier: "sliderImp").adjust(toNormalizedSliderPosition: 0.45)
        app.sliders.element(matching: .slider, identifier: "sliderImp").adjust(toNormalizedSliderPosition: 0.67)
        app.sliders.element(matching: .slider, identifier: "sliderDiff").adjust(toNormalizedSliderPosition: 0.21)
        app.buttons["Cancel"].tap()
        
        //Testing the exp popup view again: sliders and save button
        app.buttons.element(matching: .button, identifier: "expBtn").tap()
        app.sliders.element(matching: .slider, identifier: "sliderImp").adjust(toNormalizedSliderPosition: 0.53)
        app.sliders.element(matching: .slider, identifier: "sliderImp").adjust(toNormalizedSliderPosition: 0.39)
        app.sliders.element(matching: .slider, identifier: "sliderDiff").adjust(toNormalizedSliderPosition: 0.26)
        app.sliders.element(matching: .slider, identifier: "sliderImp").adjust(toNormalizedSliderPosition: 0.87)
        app.buttons["Save"].tap()
        
        //Testing the gold button
        app.buttons.element(matching: .button, identifier: "goldBtn").tap()
        app.buttons["OK"].tap()
        
        //Testing the notes popup view: textview and buttons
        app.buttons.element(matching: .button, identifier: "notesBtn").tap()
        app.textViews.element(matching: .textView, identifier: "notes").tap()
        app.textViews.element(matching: .textView, identifier: "notes").typeText("Hello")
        app.buttons["Cancel"].tap() //Testing the cancel button
        app.buttons.element(matching: .button, identifier: "notesBtn").tap()
        app.textViews.element(matching: .textView, identifier: "notes").tap()
        app.textViews.element(matching: .textView, identifier: "notes").typeText("Hello")
        app.buttons["Save"].tap() //Testing the add button
        
        //Initializing the date picker so that we'll be able to test the picker wheels
        let datePicker = XCUIApplication().datePickers
        
        //Testing the due date popup view: date picker and cancel button
        app.buttons.element(matching: .button, identifier: "dueBtn").tap()
        datePicker.pickerWheels.element(boundBy: 0).swipeUp()
        datePicker.pickerWheels.element(boundBy: 1).swipeDown()
        datePicker.pickerWheels.element(boundBy: 2).swipeUp()
        datePicker.pickerWheels.element(boundBy: 3).swipeDown()
        app.buttons["Cancel"].tap()
        
        //Testing the deu date popup view again: date picker and save button
        app.buttons.element(matching: .button, identifier: "dueBtn").tap()
        datePicker.pickerWheels.element(boundBy: 0).swipeDown()
        datePicker.pickerWheels.element(boundBy: 1).swipeUp()
        datePicker.pickerWheels.element(boundBy: 2).swipeDown()
        datePicker.pickerWheels.element(boundBy: 3).swipeUp()
        app.buttons["Save"].tap()
        
//        print(cell.label)
//        print(myTable.cells.debugDescription)
//        XCTAssert(cell.identifier == "FirstViewCell_3")
    }
    
    func testExample() {
        
    }
    
    func testLogin() {
        //Making sure we are at the correct tab
        app.tabBars.buttons["Hero"].tap()
        
        app.buttons["Login"].tap()
        app.buttons["Cancel"].tap()
        
        app.buttons["Login"].tap()
        app.textFields["email"].typeText("theNewEmail")
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText("theNewPassword")
        app.buttons["Sign up"].tap()
        
        app.buttons["Login"].tap()
        app.textFields["email"].typeText("theWrongEmail")
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText("theWrongPassword")
        app.buttons["Sign in"].tap()
        
        app.buttons["Login"].tap()
        app.textFields["email"].typeText("theCorrectEmail")
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText("theCorrectPassword")
        app.buttons["Sign in"].tap()
    }

//    func testRewards() {
//        app.tabBars.buttons["Rewards"].tap()
//        
//        var myTable = app.tables.matching(identifier: "RewardsTable")
//        var tableCell = myTable.cells.element(matching: .cell, identifier: "RewardsTableCell_0")
//        var myCollection = tableCell.collectionViews.matching(identifier: "RewardsCollection")
//        var collectionCell = myCollection.element(matching: .cell, identifier: "RewardsCollectionCell_1")
//        
//        collectionCell.tap()
//        
//    }
}
