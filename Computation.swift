//
//  Computation.swift
//  DFSwift
//
//  Created by Sinha, Gyanendra on 2/10/15.
//  Copyright (c) 2015 Sinha, Gyanendra. All rights reserved.
//

import Foundation

let syncQueue = dispatch_queue_create("com.DF.syncQueue", DISPATCH_QUEUE_SERIAL)
let messageQueue = dispatch_queue_create("com.DF.messageQueue", DISPATCH_QUEUE_SERIAL)
let startQueue = dispatch_queue_create("com.DF.startQueue", DISPATCH_QUEUE_CONCURRENT)

struct Connection {
    let task:_Task
    let number:PortNumber
    
}

class Computation:NSOperation {
    private var _lock:NSRecursiveLock = NSRecursiveLock()
    private var _suspended:Bool = false
    private var _task:_Task
    private var _connections:[Int:Connection] = [Int:Connection]()
    var state:Observable<TaskState> = Observable(.Ready)
    var queue:NSOperationQueue?
    
    init (_ task:_Task) {
        _task = task
        super.init()
    }
    
    override var executing:Bool {
        return state.raw == .Executing
    }
    
    override var ready:Bool  {
        return super.ready && state.raw == .Ready && !_suspended
    }
    
    override var finished:Bool {
        return state.raw == .Done
    }

    final func safelyExecuteClosure(closure:()->()) {
        _lock.lock()
        closure()
        _lock.unlock()
    }
    
    func connectedTasks()->[_Task] {
        return _connections.values.map({$0.task}).array
    }
    
    func addConnection(task:_Task, number:PortNumber) {
        safelyExecuteClosure { [weak self] in
            if let strongSelf = self  {
                strongSelf.removeConnection(number)
                strongSelf._connections[number.value] = Connection(task: task, number: number)
                strongSelf.addDependency(task.computation)
            }
        }
    }
    
    func removeConnection(number:PortNumber) {
        safelyExecuteClosure { [weak self] in
            if let strongSelf = self  {
                if let task = strongSelf._connections[number.value]?.task {
                    strongSelf.removeDependency(task.computation)
                }
                strongSelf._connections.removeValueForKey(number.value)
            }
        }
    }
    
    func canExecute()-> Bool {
        
    }
    
    
    func removeAllConnections() {
        safelyExecuteClosure { [weak self] in
            if let strongSelf = self  {
                var connections = strongSelf._connections
               
            }
        }
    }
    
    func _prepareForExexution() {
        
    }
    
    
    func suspended() -> Bool {
        return _suspended
    }

    func suspend() {
        
    }
    
    func resume() {
        
    }
    
    override func main() {
    
    }
    
    override func start() {
        
    }

}

