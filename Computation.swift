//
//  Computation.swift
//  DFSwift
//
//  Created by Sinha, Gyanendra on 2/10/15.
//  Copyright (c) 2015 Sinha, Gyanendra. All rights reserved.
//

import Foundation


class DFComputation<T> {
    var queue:NSOperationQueue?
    var lock:NSRecursiveLock = NSRecursiveLock()
    var task:Task?
    var output:T?
    
    init (task:Task? = nil) {
        self.task = task
    }
    
}