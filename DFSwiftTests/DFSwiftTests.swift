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

protocol Test {
    typealias T
    var x:Any {get set}
}

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
        
        var task2 = task({(a:String, b:Int) -> Int in
            return b
        })
        var task3 = task({(a: Int, b:Int, c:Int) -> Int  in
            return a
        })
        var task4 = task({(a: Int, b:Int, c:Int, d:Int) -> Int  in
            return a
        })
        
        task1~>task2.IN2
        task2~>task3.IN2
        task3~>task4.IN4
       
    }
    
    func testComputation() {
        var task2 = task({(a:Int, b:Int) -> Int in
            return a + b
        })
        task2[PORT1] = 1
        task2[PORT2] = 3
        let result = task2.compute()!
        XCTAssert(result == 4, "Result must be 4")
    }
    
    func testObserver() {
        var x:Observable<Int> = Observable(2)
        x.addObserver(ObservingType.DidSet, closure: {(a:Int, b:Int)  in
           println(a)
           println(b)
        })
        x.raw = 3
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
