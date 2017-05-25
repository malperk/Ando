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
        for _ in 0..<5 {
            ACache.shared.addItem(url: arc4random_uniform(1000).description, item: 5)
        }
        ACache.shared.addItem(url: "1_0", item: 10)
        ACache.shared.addItem(url: "1_1", item: 11)
        ACache.shared.addItem(url: "1_2", item: 12)
        ACache.shared.addItem(url: "1_3", item: 13)
        ACache.shared.addItem(url: "1_4", item: 14)
        for _ in 0..<5 {
            ACache.shared.addItem(url: arc4random_uniform(1000).description, item: 5)
        }

        ACache.shared.setMaxLenght(8)
        XCTAssertNil(ACache.shared.getItem(url:"1_0"))
        XCTAssertNil(ACache.shared.getItem(url:"1_1"))
        XCTAssertNotNil(ACache.shared.getItem(url:"1_2"))
        
        
    }
    
}
