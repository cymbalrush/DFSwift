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
    
    public var hashValue:Int {
        return value
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
    
    public var hashValue:Int {
        return value
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
    
    public var hashValue:Int {
        return value
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
    
    public var hashValue:Int {
        return value
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
    var value:Any? {get set}
}

protocol _Port:Port {
    typealias PortType
    var typedValue:PortType? {get set}
    var task:_Task {get set}
}

public struct InPort<PortType>:_Port {
    public var identifier:String? = nil
    public var desc:String? = nil
    var task:_Task
    public let number:PortNumber
    
    public var typedValue:PortType? {
        get {
            return task[number] as? PortType
        }
        set {
            task[number] = newValue
        }
    }
    public var value:Any? {
        get {
            return task[number]
        }
        set {
            task[number] = newValue
        }
    }
    
    init (number:PortNumber, task:_Task) {
        self.number = number
        self.identifier = number.description
        self.task = task
    }
}

public struct OutPort<PortType>:_Port {
    public var identifier:String? = nil
    public var desc:String? = nil
    var task:_Task
    public var typedValue:PortType? {
        get {
            return task[number] as? PortType
        }
        set {
            task[number] = newValue
        }
    }
    public var value:Any? {
        get {
            return task[number]
        }
        set {
            task[number] = newValue
        }
    }
    init (_ task:Task) {
        self.task = task
    }
}


