//
//  DFPort.swift
//  DFSwift
//
//  Created by Sinha, Gyanendra on 2/5/15.
//  Copyright (c) 2015 Sinha, Gyanendra. All rights reserved.
//

import Foundation

public protocol PortNumber:Printable {
    var value:Int {get}
}

public struct Port1:PortNumber {
    public var value:Int {
        return 1
    }
    
    public var description:String {
        return "PORT1"
    }
    
    public func toString() -> String {
        return description
    }
}

public let PORT1 = Port1()

public struct Port2:PortNumber {
    public var value:Int {
        return 2
    }
    
    public var description:String {
        return "PORT2"
    }
    
    public func toString() -> String {
        return description
    }
}

public let PORT2 = Port2()

public struct Port3:PortNumber {
    public var value:Int {
        return 3
    }
    
    public var description:String {
        return "PORT3"
    }
    
    public func toString() -> String {
        return description
    }
}

public let PORT3 = Port3()

public struct Port4:PortNumber {
    public var value:Int {
        return 4
    }
    
    public var description:String {
        return "PORT4"
    }
    
    public func toString() -> String {
        return description
    }
}

public let PORT4 = Port4()

public protocol Port {
    var identifier:String? {get set}
    var desc:String? {get set}
    var task:Task? {get set}
    var value:Any? {get set}
}

public protocol TypedPort:Port {
    typealias PortType
    var typedValue:PortType? {get set}
}

public struct InPort<PortType>:TypedPort {
    public var number:PortNumber
    public var task:Task?
    public var identifier:String? = nil
    public var desc:String? = nil
    public var typedValue:PortType? {
        get {
            return task?.portValue(number) as? PortType
        }
        set {
            task?.setPortValue(number, value: newValue)
        }
    }
    public var value:Any? {
        get {
            return task?.portValue(number)
        }
        set {
            task?.setPortValue(number, value: newValue)
        }
    }
    
    init (number:PortNumber, task:Task? = nil) {
        self.number = number
        self.identifier = number.description
        self.task = task
    }
}

public struct OutPort<T>:Port {
    public var identifier:String? = nil
    public var desc:String? = nil
    public var task:Task?
    public var value:Any?    
    init (task:Task? = nil) {
        self.task = task
    }
}


