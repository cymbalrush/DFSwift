//
//  Computation.swift
//  DFSwift
//
//  Created by Sinha, Gyanendra on 2/10/15.
//  Copyright (c) 2015 Sinha, Gyanendra. All rights reserved.
//

import Foundation

class Connection {
    var task:Task? = nil
    var state:TaskState = .Ready
    var values:[Any] = [Any]()
}

class DFComputation<T> {
    var connections:[Connection] = [Connection]()
    var task:Task? {
        didSet {
            if let task = self.task {
                connections = Array<Connection>()
                let n = task.portCount()
                connections.reserveCapacity(n)
                for i in 0..<n {
                    self.connections.append(Connection())
                }
            }
            else {
                connections = [Connection]()
            }
        }
    }
    
    var output:T?
    
    init (task:Task? = nil) {
        self.task = task
    }
    
    func canExecute() -> Bool {
        return true
    }
    
    func addConnection(task:Task, number:PortNumber)  {
        let index = number.value
        var connection = connections[index]
        
    }
    
    func isDone() -> Bool {
        return false
    }
    
}