//
//  ExampleUITests.swift
//  ExampleUITests
//
//  Created by Alper KARATAŞ on 24/05/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import XCTest

class ExampleUITests: XCTestCase {
        
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
    
    func testExample() {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).otherElements.containing(.staticText, identifier:"nicholaskampouris").element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.tap()
        
        let image = app.scrollViews.children(matching: .image).element
        image.swipeUp()
        image.swipeRight()
        image.swipeUp()
        
        let exampleBigimageviewNavigationBar = app.navigationBars["Example.BigImageView"]
        exampleBigimageviewNavigationBar.buttons["nicholaskampouris"].tap()
        app.navigationBars["nicholaskampouris"].buttons["USERS"].tap()
        collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"llyn").element.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.tap()
        exampleBigimageviewNavigationBar.buttons["llyn"].tap()
        app.navigationBars["llyn"].buttons["USERS"].tap()
        
    }
    
}
