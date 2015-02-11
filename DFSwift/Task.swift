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
    var out:OutPort<T>
    public var state:Observable<TaskState>
    public var priority:TaskPriority
    public var suspended:Bool = false
    public lazy var ports:[Port] = {
        [unowned self] in
        var array:[Port] = [Port]()
        self.addPort(&array)
        return array
    }()
    
    init () {
        state = Observable(.Ready)
        priority = .Normal
        out = OutPort<T>()
        out.task = self
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
    
    subscript(number:PortNumber) -> (InPort<Any>, PortNumber, Task)? {
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
    var in1:(InPort<T1>)
    var closure1:(T1->T)?
    
    public override init () {
        in1 = InPort<T1>(number:PortNumber1.Port1)
        super.init()
        in1.task = self
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
    
    func port(number:PortNumber1) -> (InPort<T1>, PortNumber1, DFTask1<T1, T>) {
        return (in1, PortNumber1.Port1, self)
    }
    
    subscript(number:PortNumber1) -> (InPort<T1>, PortNumber1, DFTask1<T1, T>) {
        return port(number)
    }
    
    func connect(task:DFTask<T1>, number:PortNumber1) -> DFTask1<T1, T> {
        return self
    }
    
    func setPortValue(number:PortNumber1, value:T1) {
         x1 = value
    }
    
    func portValue(number:PortNumber1) -> T1? {
        return x1
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(in1)
    }
}

public class DFTask2<T1, T2, T> :  DFTask1<T1, T> {
    var x2:T2?
    var in2:InPort<T2>
    var closure2:((T1, T2) -> (T))?
    
    override init () {
        in2 = InPort<T2>(number:PortNumber2.Port2)
        super.init()
        in2.task = self
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
    
    func port(number:PortNumber2) -> (InPort<T2>, PortNumber2, DFTask2<T1, T2, T>) {
        return (in2, PortNumber2.Port2, self)
    }
    
    subscript(number:PortNumber2) -> (InPort<T2>, PortNumber2, DFTask2<T1, T2, T>) {
        return port(number)
    }
    
    func connect(task:DFTask<T2>, number:PortNumber2) -> DFTask2<T1, T2, T> {
        return self
    }
    
    func setPortValue(number:PortNumber2, value:T2) {
        x2 = value
    }
    
    func portValue(number:PortNumber2) -> T2? {
        return x2
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(in2)
    }
}

public class DFTask3<T1, T2, T3, T> : DFTask2<T1, T2, T> {
    var x3:T3?
    var in3:InPort<T3>
    var closure3:((T1, T2, T3)->(T))?
    
    override init () {
        in3 = InPort<T3>(number:PortNumber3.Port3)
        super.init()
        in3.task = self
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
    
    func port(number:PortNumber3) -> (InPort<T3>, PortNumber3, DFTask3<T1, T2, T3, T>) {
        return (in3, PortNumber3.Port3, self)
    }
    
    subscript(number:PortNumber3) -> (InPort<T3>, PortNumber3, DFTask3<T1, T2, T3, T>) {
        return port(number)
    }
    
    func connect(task:DFTask<T3>, number:PortNumber3) -> DFTask3<T1, T2, T3, T> {
        return self
    }
    
    func setPortValue(number:PortNumber3, value:T3) {
        x3 = value
    }
    
    func portValue(number:PortNumber3) -> T3? {
        return x3
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(in3)
    }
}

public class DFTask4<T1, T2, T3, T4, T> : DFTask3<T1, T2, T3, T> {
    var x4:T4?
    var in4:InPort<T4>
    var closure4:((T1, T2, T3, T4)->(T))?
    
    override init () {
        in4 = InPort<T4>(number:PortNumber4.Port4)
        super.init()
        in4.task = self
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
    
    func port(number:PortNumber4) -> (InPort<T4>, PortNumber4, DFTask4<T1, T2, T3, T4, T>) {
        return (in4, PortNumber4.Port4, self)
    }
    
    subscript(number:PortNumber4) -> (InPort<T4>, PortNumber4, DFTask4<T1, T2, T3, T4, T>) {
        return port(number)
    }
    
    func connect(task:DFTask<T4>, number:PortNumber4) -> DFTask4<T1, T2, T3, T4, T> {
        return self
    }
    
    func setPortValue(number:PortNumber4, value:T4) {
        x4 = value
    }
    
    func portValue(number:PortNumber4) -> T4? {
        return x4
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(in4)
    }
}

public class DFTask5<T1, T2, T3, T4, T5, T> : DFTask4<T1, T2, T3, T4, T> {
    var x5:T5?
    var in5:InPort<T5>
    var closure5:((T1, T2, T3, T4, T5)->(T))?
    
    override init () {
        in5 = InPort<T5>(number:PortNumber5.Port5)
        super.init()
        in5.task = self
    }
    
    convenience init (_ closure:((T1, T2, T3, T4, T5) ->(T))) {
        self.init()
        closure5 = closure
    }
    
    override func compute()->T? {
        if let closure = closure5 {
            var result:T!
            autoreleasepool {
                result = closure(self.x1!, self.x2!, self.x3!, self.x4!, self.x5!)
            }
            return result
        }
        return nil;
    }
    
    public override func portCount() -> Int {
        return 5
    }
    
    func port(number:PortNumber5) -> (InPort<T5>, PortNumber5, DFTask5<T1, T2, T3, T4, T5, T>) {
        return (in5, PortNumber5.Port5, self)
    }
    
    subscript(number:PortNumber5) -> (InPort<T5>, PortNumber5, DFTask5<T1, T2, T3, T4, T5, T>) {
        return port(number)
    }
    
    func connect(task:DFTask<T5>, number:PortNumber5) -> DFTask5<T1, T2, T3, T4, T5, T> {
        return self
    }
    
    func setPortValue(number:PortNumber5, value:T5) {
        x5 = value
    }
    
    func portValue(number:PortNumber5) -> T5? {
        return x5
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(in5)
    }
}

public class DFTask6<T1, T2, T3, T4, T5, T6, T> : DFTask5<T1, T2, T3, T4, T5, T> {
    var x6:T6?
    var in6:InPort<T6>
    var closure6:((T1, T2, T3, T4, T5, T6)->(T))?
    
    override init () {
        in6 = InPort<T6>(number:PortNumber6.Port6)
        super.init()
        in6.task = self
    }
    
    convenience init (_ closure:((T1, T2, T3, T4, T5, T6) ->(T))) {
        self.init()
        closure6 = closure
    }
    
    override func compute()->T? {
        if let closure = closure6 {
            var result:T!
            autoreleasepool {
                result = closure(self.x1!, self.x2!, self.x3!, self.x4!, self.x5!, self.x6!)
            }
            return result
        }
        return nil;
    }
    
    public override func portCount() -> Int {
        return 6
    }
    
    func port(number:PortNumber6) -> (InPort<T6>, PortNumber6, DFTask6<T1, T2, T3, T4, T5, T6, T>) {
        return (in6, PortNumber6.Port6, self)
    }
    
    subscript(number:PortNumber6) -> (InPort<T6>, PortNumber6, DFTask6<T1, T2, T3, T4, T5, T6, T>) {
        return port(number)
    }
    
    func connect(task:DFTask<T6>, number:PortNumber6) -> DFTask6<T1, T2, T3, T4, T5, T6, T> {
        return self
    }
    
    func setPortValue(number:PortNumber6, value:T6) {
        x6 = value
    }
    
    func portValue(number:PortNumber6) -> T6? {
        return x6
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(in6)
    }
}

public class DFTask7<T1, T2, T3, T4, T5, T6, T7, T> : DFTask6<T1, T2, T3, T4, T5, T6, T> {
    var x7:T7?
    var in7:InPort<T7>
    var closure7:((T1, T2, T3, T4, T5, T6, T7)->(T))?
    
    override init () {
        in7 = InPort<T7>(number:PortNumber7.Port7)
        super.init()
        in7.task = self
    }
    
    convenience init (_ closure:((T1, T2, T3, T4, T5, T6, T7) ->(T))) {
        self.init()
        closure7 = closure
    }
    
    override func compute()->T? {
        if let closure = closure7 {
            var result:T!
            autoreleasepool {
                result = closure(self.x1!, self.x2!, self.x3!, self.x4!, self.x5!, self.x6!, self.x7!)
            }
            return result
        }
        return nil;
    }
    
   public override func portCount() -> Int {
        return 7
    }
    
    func port(number:PortNumber7) -> (InPort<T7>, PortNumber7, DFTask7<T1, T2, T3, T4, T5, T6, T7, T>) {
        return (in7, PortNumber7.Port7, self)
    }
    
    subscript(number:PortNumber7) -> (InPort<T7>, PortNumber7, DFTask7<T1, T2, T3, T4, T5, T6, T7, T>) {
        return port(number)
    }
    
    func connect(task:DFTask<T7>, number:PortNumber7) -> DFTask7<T1, T2, T3, T4, T5, T6, T7, T> {
        return self
    }
    
    func setPortValue(number:PortNumber7, value:T7) {
        x7 = value
    }
    
    func portValue(number:PortNumber7) -> T7? {
        return x7
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(in7)
    }
}

public class DFTask8<T1, T2, T3, T4, T5, T6, T7, T8, T> : DFTask7<T1, T2, T3, T4, T5, T6, T7, T> {
    var x8:T8?
    var in8:InPort<T8>
    var closure8:((T1, T2, T3, T4, T5, T6, T7, T8)->(T))?
    
    override init () {
        in8 = InPort<T8>(number:PortNumber8.Port8)
        super.init()
        in8.task = self
    }
    
    convenience init (_ closure:((T1, T2, T3, T4, T5, T6, T7, T8) ->(T))) {
        self.init()
        closure8 = closure
    }
    
    override func compute()->T? {
        if let closure = closure8 {
            var result:T!
            autoreleasepool {
                result = closure(self.x1!, self.x2!, self.x3!, self.x4!, self.x5!, self.x6!, self.x7!, self.x8!)
            }
            return result
        }
        return nil;
    }
    
    public override func portCount() -> Int {
        return 8
    }
    
    func port(number:PortNumber8) -> (InPort<T8>, PortNumber8, DFTask8<T1, T2, T3, T4, T5, T6, T7, T8, T>) {
        return (in8, PortNumber8.Port8, self)
    }
    
    subscript(number:PortNumber8) -> (InPort<T8>, PortNumber8, DFTask8<T1, T2, T3, T4, T5, T6, T7, T8, T>) {
        return port(number)
    }

    func connect(task:DFTask<T8>, number:PortNumber8) -> DFTask8<T1, T2, T3, T4, T5, T6, T7, T8, T> {
        return self
    }
    
    func setPortValue(number:PortNumber8, value:T8) {
        x8 = value
    }
    
    func portValue(number:PortNumber8) -> T8? {
        return x8
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(in8)
    }
}

public class DFTask9<T1, T2, T3, T4, T5, T6, T7, T8, T9, T> : DFTask8<T1, T2, T3, T4, T5, T6, T7, T8, T> {
    var x9:T9?
    var in9:InPort<T9>
    var closure9:((T1, T2, T3, T4, T5, T6, T7, T8, T9)->(T))?
    
    override init () {
        in9 = InPort<T9>(number:PortNumber9.Port9)
        super.init()
        in9.task = self
    }
    
    convenience init (_ closure:((T1, T2, T3, T4, T5, T6, T7, T8, T9) ->(T))) {
        self.init()
        closure9 = closure
    }
    
    override func compute()->T? {
        if let closure = closure9 {
            var result:T!
            autoreleasepool {
                result = closure(self.x1!, self.x2!, self.x3!, self.x4!, self.x5!, self.x6!, self.x7!, self.x8!, self.x9!)
            }
            return result
        }
        return nil;
    }
    
    public override func portCount() -> Int {
        return 9
    }
    
    func port(number:PortNumber9) -> (InPort<T9>, PortNumber9, DFTask9<T1, T2, T3, T4, T5, T6, T7, T8, T9, T>) {
        return (in9, PortNumber9.Port9, self)
    }
    
    subscript(number:PortNumber9) -> (InPort<T9>, PortNumber9, DFTask9<T1, T2, T3, T4, T5, T6, T7, T8, T9, T>) {
        return port(number)
    }
    
    func connect(task:DFTask<T9>, number:PortNumber9) -> DFTask9<T1, T2, T3, T4, T5, T6, T7, T8, T9, T> {
        return self
    }
    
    func setPortValue(number:PortNumber9, value:T9) {
        x9 = value
    }
    
    func portValue(number:PortNumber9) -> T9? {
        return x9
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(in9)
    }
}

public class DFTask10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T> : DFTask9<T1, T2, T3, T4, T5, T6, T7, T8, T9, T> {
    var x10:T10?
    var in10:InPort<T10>
    var closure10:((T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)->(T))?
    
    override init () {
        in10 = InPort<T10>(number:PortNumber10.Port10)
        super.init()
        in10.task = self
    }
    
    convenience init (_ closure:((T1, T2, T3, T4, T5, T6, T7, T8, T9, T10) ->(T))) {
        self.init()
        closure10 = closure
    }
    
    override func compute()->T? {
        if let closure = closure10 {
            var result:T!
            autoreleasepool {
                result = closure(self.x1!, self.x2!, self.x3!, self.x4!, self.x5!, self.x6!, self.x7!, self.x8!, self.x9!, self.x10!)
            }
            return result
        }
        return nil;
    }
    
    public override func portCount() -> Int {
        return 10
    }
    
    func port(number:PortNumber10) -> (InPort<T10>, PortNumber10, DFTask10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T>) {
        return (in10, PortNumber10.Port10, self)
    }
    
    subscript(number:PortNumber10) -> (InPort<T10>, PortNumber10, DFTask10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T>) {
        return port(number)
    }
    
    func connect(task:DFTask<T10>, number:PortNumber10) -> DFTask10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T> {
        return self
    }
    
    func setPortValue(number:PortNumber10, value:T10) {
        x10 = value
    }
    
    func portValue(number:PortNumber10) -> T10? {
        return x10
    }
    
    override func addPort(inout ports:[Port]) {
        super.addPort(&ports)
        ports.append(in10)
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

public func task<T1, T2, T3, T4, T5, T>(closure : ((T1, T2, T3, T4, T5) ->(T))) -> DFTask5<T1, T2, T3, T4, T5, T> {
    return DFTask5(closure);
}

public func task<T1, T2, T3, T4, T5, T6, T>(closure : ((T1, T2, T3, T4, T5, T6) ->(T))) -> DFTask6<T1, T2, T3, T4, T5, T6, T> {
    return DFTask6(closure);
}

public func task<T1, T2, T3, T4, T5, T6, T7, T>(closure : ((T1, T2, T3, T4, T5, T6, T7) ->(T))) -> DFTask7<T1, T2, T3, T4, T5, T6, T7, T> {
    return DFTask7(closure);
}

func task<T1, T2, T3, T4, T5, T6, T7, T8, T>(closure : ((T1, T2, T3, T4, T5, T6, T7, T8) ->(T))) -> DFTask8<T1, T2, T3, T4, T5, T6, T7, T8, T> {
    return DFTask8(closure);
}

func task<T1, T2, T3, T4, T5, T6, T7, T8, T9, T>(closure : ((T1, T2, T3, T4, T5, T6, T7, T8, T9) ->(T))) -> DFTask9<T1, T2, T3, T4, T5, T6, T7, T8, T9, T> {
    return DFTask9(closure);
}

func task<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T>(closure : ((T1, T2, T3, T4, T5, T6, T7, T8, T9, T10) ->(T))) -> DFTask10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T> {
    return DFTask10(closure);
}

infix operator ~> { associativity left precedence 140 } // 1

public func ~><T1, T>(task:DFTask<T1>, tuple:(InPort<T1>, PortNumber1,  DFTask1<T1, T>)) -> DFTask1<T1, T> {
    return tuple.2.connect(task, number: .Port1)
}

public func ~><T1, T2, T >(task:DFTask<T2>, tuple:(InPort<T2>, PortNumber2, DFTask2<T1, T2, T>)) -> DFTask2<T1, T2, T> {
    return tuple.2.connect(task, number: .Port2)
}

public func ~><T1, T2, T3, T>(task:DFTask<T3>, tuple:(InPort<T3>, PortNumber3, DFTask3<T1, T2, T3, T>)) -> DFTask3<T1, T2, T3, T> {
    return tuple.2.connect(task, number: .Port3)
}

public func ~><T1, T2, T3, T4, T>(task:DFTask<T4>, tuple:(InPort<T4>, PortNumber4, DFTask4<T1, T2, T3, T4, T>)) -> DFTask4<T1, T2, T3, T4, T> {
    return tuple.2.connect(task, number: .Port4)
}

public func ~><T1, T2, T3, T4, T5, T>(task:DFTask<T5>, tuple:(InPort<T5>,  PortNumber5, DFTask5<T1, T2, T3, T4, T5, T>)) -> DFTask5<T1, T2, T3, T4, T5, T>? {
    return tuple.2.connect(task, number: .Port5)
}

public func ~><T1, T2, T3, T4, T5, T6, T>(task:DFTask<T6>, tuple:(InPort<T6>, PortNumber6, DFTask6<T1, T2, T3, T4, T5, T6, T>)) -> DFTask6<T1, T2, T3, T4, T5, T6, T> {
    return tuple.2.connect(task, number: .Port6)
}

public func ~><T1, T2, T3, T4, T5, T6, T7, T>(task:DFTask<T7>, tuple:(InPort<T7>, PortNumber7, DFTask7<T1, T2, T3, T4, T5, T6, T7, T>)) -> DFTask7<T1, T2, T3, T4, T5, T6, T7, T> {
    return tuple.2.connect(task, number: .Port7)
}

public func ~><T1, T2, T3, T4, T5, T6, T7,  T8, T>(task:DFTask<T8>, tuple:(InPort<T8>, PortNumber8, DFTask8<T1, T2, T3, T4, T5, T6, T7, T8, T>)) -> DFTask8<T1, T2, T3, T4, T5, T6, T7, T8, T> {
    return tuple.2.connect(task, number: .Port8)
}

public func ~><T1, T2, T3, T4, T5, T6, T7, T8, T9, T>(task:DFTask<T9>, tuple:(InPort<T9>, PortNumber9, DFTask9<T1, T2, T3, T4, T5, T6, T7, T8, T9, T>)) -> DFTask9<T1, T2, T3, T4, T5, T6, T7, T8, T9, T> {
    return tuple.2.connect(task, number: .Port9)
}

public func ~><T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T>(task:DFTask<T10>, tuple:(InPort<T10>, PortNumber10, DFTask10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T>)) -> DFTask10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T> {
    return tuple.2.connect(task, number: .Port10)
}

