//
//  AndoTests.swift
//  AndoTests
//
//  Created by Alper KARATAŞ on 23/05/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import XCTest
@testable import Ando

class AndoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWrongURL() {
        let asyncExpectation = expectation(description: "testWrongURL")
        
        let dwn = Ando()
        dwn.callback = {response in
            XCTAssertNil(response.item)
            XCTAssertNotNil(response.error)
            XCTAssertEqual(response.error?.code, AError.Code.WrongURL.rawValue)
            asyncExpectation.fulfill()
        }
        dwn.url = "wrong url"
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
        }
    }
    
    func testGetImage() {
        let asyncExpectation = expectation(description: "testGetImage")
        
        let dwn = Ando()
        dwn.callback = {response in
            XCTAssertNil(response.error)
            XCTAssertNotNil(response.item)
            asyncExpectation.fulfill()
        }
        dwn.url = "http://httpbin.org/image/png"
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
        }
    }
    
}
