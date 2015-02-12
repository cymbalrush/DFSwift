//
//  DFSwiftTests.swift
//  DFSwiftTests
//
//  Created by Sinha, Gyanendra on 2/5/15.
//  Copyright (c) 2015 Sinha, Gyanendra. All rights reserved.
//

import UIKit
import XCTest
import DFSwift

class DFSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTaskCreation() {
        var task0 = task({() -> Int in
            return 1
        })
        XCTAssert(task0.ports.count == 0, "Port count must be 0")
        
        
        var task1 = task({(a:Int) -> Int in
            return a
        })
        XCTAssert(task1.ports.count == 1, "Port count must be 1")
        
        
        var task2 = task({(a:Int, b:Int) -> Int in
            return a
        })
        XCTAssert(task2.ports.count == 2, "Port count must be 2")
        
        var task3 = task({(a: Int, b:Int, c:Int) -> Int  in
            return a
        })
        XCTAssert(task3.ports.count == 3, "Port count must be 3")
        
        var task4 = task({(a: Int, b:Int, c:Int, d:Int) -> Int  in
            return a
        })
        XCTAssert(task4.ports.count == 4, "Port count must be 4")

    }
    
    func testTaskBinding() {
        var task0 = task({() -> Int in
            return 1
        })
        
        var task1 = task({(a:Int) -> Int in
            return a
        })
        var task2 = task({(a:Int, b:Int) -> Int in
            return a
        })
        var task3 = task({(a: Int, b:Int, c:Int) -> Int  in
            return a
        })
        var task4 = task({(a: Int, b:Int, c:Int, d:Int) -> Int  in
            return a
        })
        task1~>task2[.Port1]~>task3[.Port3]

    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
