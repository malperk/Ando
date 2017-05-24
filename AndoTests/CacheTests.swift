//
//  CacheTests.swift
//  Ando
//
//  Created by Alper KARATAŞ on 23/05/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import XCTest
@testable import Ando

class CacheTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testChangeMaxLenght() {
        for _ in 0..<59 {
            ACache.shared.addItem(url: arc4random_uniform(1000).description, item: 5)
        }
        ACache.shared.setMaxLenght(20)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
