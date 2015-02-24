//
//  Computation.swift
//  DFSwift
//
//  Created by Sinha, Gyanendra on 2/5/15.
//  Copyright (c) 2015 Sinha, Gyanendra. All rights reserved.
//

import Foundation

public enum TaskState:Int {
    case Ready, Executing, Done
}

public enum TaskPriority:Int {
    case High, Normal, Low, Background
}

public protocol Task {
    var state:Observable<TaskState> {get set}
    var priority:TaskPriority {get set}
    var suspended:Bool {get}
    func pause()
    func resume()
    func cancel()
    func clone()->Task
    func portCount()->Int
    func port(number:PortNumber) -> (InPort<Any>, PortNumber, Task)?
    func connect(task:Task, number:PortNumber) -> Task?
    func setPortValue(number:PortNumber, value:Any)
    func portValue(number:PortNumber) ->Any?
}

public class DFTask<T>:Task {
    var closure0:(()->T)?
    public var state:Observable<TaskState>
    public var priority:TaskPriority
    public var suspended:Bool = false
    private(set) lazy var out:OutPort<T> = {
        [unowned self] in
        return OutPort<T>(task: self)
    }()
    public lazy var ports:[Port] = {
        [unowned self] in
        var array:[Port] = [Port]()
        self.addPort(&array)
        return array
    }()
    
     init () {
        state = Observable(.Ready)
        priority = .Normal
    }
    
   convenience init (_ closure:()->T) {
        self.init()
        closure0 = closure
    }
    
    func compute()->T? {
        if let closure = closure0  {
            var result:T!
            autoreleasepool {
                result = closure()
            }
            return result
        }
        return nil;
    }
    
    func execute()->T? {
        if let closure = closure0  {
            var result:T!
            autoreleasepool {
                result = closure()
            }
            return result
        }
        return nil;
    }
    
    public func pause() {}
    
    public func resume() {}
    
    public func cancel() {}
    
    public func clone()->Task {
        return self
    }
    
    public func portCount() -> Int {
        return 0;
    }
    
    public func port(number:PortNumber) -> (InPort<Any>, PortNumber, Task)? {
        return nil
    }
    
    public subscript(number:PortNumber) -> (InPort<Any>, PortNumber, Task)? {
        return nil
    }
    
    public func connect(task: Task, number: PortNumber) -> Task? {
        return nil
    }
    
    public func setPortValue(number:PortNumber, value:Any) {}
    
    public func portValue(number:PortNumber) ->Any? {
        return nil
    }
    
    func addPort(inout ports:[Port]) {}
}

public class DFTask1 <T1, T> : DFTask<T> {
    var x1:T1?
    var closure1:(T1->T)?
    private(set) lazy var in1:InPort<T1> = {
        [unowned self] in
        return InPort<T1>(number:PORT1, task:self)
    }()
    
    public override init () {
        super.init()
    }
    
    convenience init (_ closure:T1 ->T) {
        self.init()
        closure1 = closure
    }
    
    override func compute()->T? {
        if let computation = closure1  {
            var result:T!
            autoreleasepool {
                result = computation(self.x1!)
            }
            return result
        }
        return nil;
    }
    
    override public func portCount() -> Int {
        return 1;
    }
    
    func port(number:Port1) -> (InPort<T1>, Port1, DFTask1<T1, T>) {
        return (in1, PORT1, self)
    }
    
    public subscript(number:Port1) -> (InPort<T1>, Port1, DFTask1<T1, T>) {
        return port(number)
    }
    
    func connect(task:DFTask<T1>, number:Port1) -> DFTask1<T1, T> {
        return self
    }
    
    func setPortValue(number:Port1, value:T1) {
         x1 = value
    }
    
    func portValue(number:Port1) -> T1? {
        return x1
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(in1)
    }
}

public class DFTask2<T1, T2, T> :  DFTask1<T1, T> {
    var x2:T2?
    var closure2:((T1, T2) -> (T))?
    private(set) lazy var in2:InPort<T2> = {
        [unowned self] in
        return InPort<T2>(number:PORT2, task:self)
    }()
    
    public override init () {
        super.init()
    }
    
    convenience init (_ closure:((T1, T2) -> (T))) {
        self.init()
        closure2 = closure
    }
    
    override func compute()->T? {
        if let computation = closure2 {
            var result:T!
            autoreleasepool {
                result = computation(self.x1!, self.x2!)
            }
            return result
        }
        return nil;
    }
    
    public override func portCount() -> Int {
        return 2
    }
    
    func port(number:Port2) -> (InPort<T2>, Port2, DFTask2<T1, T2, T>) {
        return (in2, PORT2, self)
    }
    
    public subscript(number:Port2) -> (InPort<T2>, Port2, DFTask2<T1, T2, T>) {
        return port(number)
    }
    
    func connect(task:DFTask<T2>, number:Port2) -> DFTask2<T1, T2, T> {
        return self
    }
    
    func setPortValue(number:Port2, value:T2) {
        x2 = value
    }
    
    func portValue(number:Port2) -> T2? {
        return x2
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(in2)
    }
}

public class DFTask3<T1, T2, T3, T> : DFTask2<T1, T2, T> {
    var x3:T3?
    var closure3:((T1, T2, T3)->(T))?
    private(set) lazy var in3:InPort<T3> = {
        [unowned self] in
        return InPort<T3>(number:PORT3, task:self)
    }()
    
    public override init () {
        super.init()
    }
    
    convenience init (_ closure:((T1, T2, T3) ->(T))) {
        self.init()
        closure3 = closure
    }
    
    override func compute()->T? {
        if let closure = closure3 {
            var result:T!
            autoreleasepool {
                result = closure(self.x1!, self.x2!, self.x3!)
            }
            return result
        }
        return nil;
    }
    
    public override func portCount() -> Int {
        return 3
    }
    
    func port(number:Port3) -> (InPort<T3>, Port3, DFTask3<T1, T2, T3, T>) {
        return (in3, PORT3, self)
    }
    
    public subscript(number:Port3) -> (InPort<T3>, Port3, DFTask3<T1, T2, T3, T>) {
        return port(number)
    }
    
    func connect(task:DFTask<T3>, number:Port3) -> DFTask3<T1, T2, T3, T> {
        return self
    }
    
    func setPortValue(number:Port3, value:T3) {
        x3 = value
    }
    
    func portValue(number:Port3) -> T3? {
        return x3
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(in3)
    }
}

public class DFTask4<T1, T2, T3, T4, T> : DFTask3<T1, T2, T3, T> {
    var x4:T4?
    var closure4:((T1, T2, T3, T4)->(T))?
    private(set) lazy var in4:InPort<T4> = {
        [unowned self] in
        return InPort<T4>(number:PORT4, task:self)
    }()
    
    public override init () {
        super.init()
    }
    
    convenience init (_ closure:((T1, T2, T3, T4) ->(T))) {
        self.init()
        closure4 = closure
    }
    
    override func compute()->T? {
        if let closure = closure4 {
            var result:T!
            autoreleasepool {
                result = closure(self.x1!, self.x2!, self.x3!, self.x4!)
            }
            return result
        }
        return nil;
    }
    
    public override func portCount() -> Int {
        return 4
    }
    
    func port(number:Port4) -> (InPort<T4>, Port4, DFTask4<T1, T2, T3, T4, T>) {
        return (in4, PORT4, self)
    }
    
    public subscript(number:Port4) -> (InPort<T4>, Port4, DFTask4<T1, T2, T3, T4, T>) {
        return port(number)
    }
    
    func connect(task:DFTask<T4>, number:Port4) -> DFTask4<T1, T2, T3, T4, T> {
        return self
    }
    
    func setPortValue(number:Port4, value:T4) {
        x4 = value
    }
    
    func portValue(number:Port4) -> T4? {
        return x4
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(in4)
    }
}

public func task<T>(closure : (() ->(T))) -> DFTask<T> {
    return DFTask(closure);
}

public func task<T1, T>(closure : (T1 ->T)) -> DFTask1<T1, T> {
    return DFTask1(closure);
}

public func task<T1, T2, T>(closure : ((T1, T2) ->(T))) -> DFTask2<T1, T2, T> {
    return DFTask2(closure);
}

public func task<T1, T2, T3, T>(closure : ((T1, T2, T3) ->(T))) -> DFTask3<T1, T2, T3, T> {
    return DFTask3(closure);
}

public func task<T1, T2, T3, T4, T>(closure : ((T1, T2, T3, T4) ->(T))) -> DFTask4<T1, T2, T3, T4, T> {
    return DFTask4(closure);
}


