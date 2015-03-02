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

public protocol Task {
    var state:Observable<TaskState> {get set}
    var ports:[Port] {get}
    var suspended:Bool {get}
    var priority:NSOperationQueuePriority {get set}
    func start()
    func cancel()
    func suspend()
    func resume()
    func portCount()->Int
    func connect(task:Task, number:PortNumber) -> Task?
}

protocol _Task:Task {
    subscript(number:PortNumber) -> Any? {get set}
    func port(PortNumber)->InPort<Any>?
    func clone()->Self
    var computation:Computation {get set}
}

public class DFTask<T>:_Task {
    private var _closure0:(()->T)?
    private var _ports:[Port]
    var computation:Computation
    public var ports:[Port] {return _ports}
    public var state:TaskState {
        return computation.state.raw
    }
    public var priority:NSOperationQueuePriority {
        get {
            return computation.queuePriority
        
        }
        set {
            computation.queuePriority = newValue
        }
    }
    public var OUT:OutPort<T> {
        return OutPort<T>(task: self)
    }
    
    init () {
        _ports = [Port]()
        self.addPort(&_ports)
    }
    
    convenience init (_ closure:()->T) {
        self.init()
        _closure0 = closure
    }
    

    public func compute()->T? {
        if let closure = _closure0  {
            var result:T!
            autoreleasepool {
                result = closure()
            }
            return result
        }
        return nil;
    }
    
    
    public func start() {
        computation.start()
    }
    
    public func suspend() {
        computation.suspend()
    }
    
    public func resume() {
       computation.resume()
    }
    
    public func cancel() {
       computation.cancel()
    }

    public func clone()->Task {
        return self
    }
    
    public func portCount() -> Int {
        return 0;
    }
    
    subscript(number:PortNumber) -> Any? {
        get {
            return nil
        }
        set {}
    }

    public func connect(task: Task, number: PortNumber) -> Task? {
        return self
    }
    
    func addPort(inout ports:[Port]) {}
    
    func port(PortNumber)->InPort<Any>? {
        return nil
    }
   
}

public class DFTask1 <T1, T> : DFTask<T> {
    private var x1_:T1?
    private var closure1_:(T1->T)?
    public var IN1:(InPort<T1>, Port1, DFTask1<T1, T>) {
        return (InPort<T1>(number:PORT1, task:self), PORT1, self)
    }
    
    public override init () {
        super.init()
    }
    
    convenience init (_ closure:T1 ->T) {
        self.init()
        closure1_ = closure
    }
    
    override public func compute()->T? {
        if let computation = closure1_  {
            var result:T!
            autoreleasepool {
                result = computation(self.x1_!)
            }
            return result
        }
        return nil;
    }
    
    override public func portCount() -> Int {
        return 1;
    }
    
    public subscript(number:Port1) -> T1? {
        get {
            return x1_
        }
        set {
            x1_ = newValue
        }
    }
    
    func connect(task:DFTask<T1>, number:Port1) -> DFTask1<T1, T> {
        return self
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(InPort<T1>(number:PORT1, task:self))
    }
    
    func port(Port1)->InPort<T1> {
        return IN1.0
    }
}

public class DFTask2<T1, T2, T> :  DFTask1<T1, T> {
    private var x2_:T2?
    private var closure2_:((T1, T2) -> (T))?
    public var IN2:(InPort<T2>, Port2, DFTask2<T1, T2, T>) {
        return (InPort<T2>(number:PORT2, task:self), PORT2, self)
    }
    
    public override init () {
        super.init()
    }
    
    convenience init (_ closure:((T1, T2) -> (T))) {
        self.init()
        closure2_ = closure
    }
    
    override public func compute()->T? {
        if let computation = closure2_ {
            var result:T!
            autoreleasepool {
                result = computation(self.x1_!, self.x2_!)
            }
            return result
        }
        return nil;
    }
    
    public override func portCount() -> Int {
        return 2
    }
    
    public subscript(number:Port2) -> T2? {
        get {
            return x2_
        }
        set {
            x2_ = newValue
        }
    }
    
    func connect(task:DFTask<T2>, number:Port2) -> DFTask2<T1, T2, T> {
        return self
    }

    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(InPort<T2>(number:PORT2, task:self))
    }
    
    func port(Port2)->InPort<T2> {
        return IN2.0
    }
}

public class DFTask3<T1, T2, T3, T> : DFTask2<T1, T2, T> {
    private var x3_:T3?
    private var closure3_:((T1, T2, T3)->(T))?
    public var IN3:(InPort<T3>, Port3, DFTask3<T1, T2, T3, T>) {
        return (InPort<T3>(number:PORT3, task:self), PORT3, self)
    }
    
    public override init () {
        super.init()
    }
    
    convenience init (_ closure:((T1, T2, T3) ->(T))) {
        self.init()
        closure3_ = closure
    }
    
    override public func compute()->T? {
        if let closure = closure3_ {
            var result:T!
            autoreleasepool {
                result = closure(self.x1_!, self.x2_!, self.x3_!)
            }
            return result
        }
        return nil;
    }
    
    public override func portCount() -> Int {
        return 3
    }
   
    func connect(task:DFTask<T3>, number:Port3) -> DFTask3<T1, T2, T3, T> {
        return self
    }
   
    public subscript(number:Port3) -> T3? {
        get {
            return x3_
        }
        set {
            x3_ = newValue
        }
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(InPort<T3>(number:PORT3, task:self))
    }
}

public class DFTask4<T1, T2, T3, T4, T> : DFTask3<T1, T2, T3, T> {
    private var x4_:T4?
    private var closure4_:((T1, T2, T3, T4)->(T))?
    public var IN4:(InPort<T4>, Port4, DFTask4<T1, T2, T3, T4, T>) {
        return (InPort<T4>(number:PORT4, task:self), PORT4, self)
    }
    
    public override init () {
        super.init()
    }
    
    convenience init (_ closure:((T1, T2, T3, T4) ->(T))) {
        self.init()
        closure4_ = closure
    }
    
    override public func compute()->T? {
        if let closure = closure4_ {
            var result:T!
            autoreleasepool {
                result = closure(self.x1_!, self.x2_!, self.x3_!, self.x4_!)
            }
            return result
        }
        return nil;
    }
    
    public override func portCount() -> Int {
        return 4
    }
    
    public subscript(number:Port4) -> T4? {
        get {
            return x4_
        }
        set {
            x4_ = newValue
        }
    }
    
    func connect(task:DFTask<T4>, number:Port4) -> DFTask4<T1, T2, T3, T4, T> {
        return self
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(InPort<T4>(number:PORT4, task:self))
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


