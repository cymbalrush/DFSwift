//
//  DFPort.swift
//  DFSwift
//
//  Created by Sinha, Gyanendra on 2/5/15.
//  Copyright (c) 2015 Sinha, Gyanendra. All rights reserved.
//

import Foundation

public protocol PortNumber:Printable {}

public enum PortNumber1:Int, PortNumber, Printable  {
    case Port1 = 1
    
    public var description:String {
        return "PORT_1"
    }
    
    func toString() -> String {
        return description
    }
}

public enum PortNumber2:Int, PortNumber {
    case Port2 = 2
    
    public var description:String {
        return "PORT_2"
    }
    
    func toString() -> String {
        return description
    }
}

public enum PortNumber3:Int, PortNumber {
    case Port3 = 3
    
    public var description:String {
        return "PORT_3"
    }
    
    func toString() -> String {
        return description
    }
}

public enum PortNumber4:Int, PortNumber {
    case Port4 = 4
    
    public var description:String {
        return "PORT_4"
    }
    
    func toString() -> String {
        return description
    }
}

public enum PortNumber5:Int, PortNumber {
    case Port5 = 5
    
    public var description:String {
        return "PORT_5"
    }
    
    func toString() -> String {
        return description
    }
}

public enum PortNumber6:Int, PortNumber {
    case Port6 = 6
    
    public var description:String {
        return "PORT_6"
    }
    
    func toString() -> String {
        return description
    }
}

public enum PortNumber7:Int, PortNumber {
    case Port7 = 7
    
    public var description:String {
        return "PORT_7"
    }
    
    func toString() -> String {
        return description
    }
}

public enum PortNumber8:Int, PortNumber {
    case Port8 = 8
    
    public var description:String {
        return "PORT_8"
    }
    
    func toString() -> String {
        return description
    }
}

public enum PortNumber9:Int, PortNumber {
    case Port9 = 9
    
    public var description:String {
        return "PORT_9"
    }
    
    func toString() -> String {
        return description
    }
}

public enum PortNumber10:Int, PortNumber {
    case Port10 = 10
    
    public var description:String {
        return "PORT_10"
    }
    
    func toString() -> String {
        return description
    }
}

public protocol Port {
    var identifier:String? {get set}
    var desc:String? {get set}
    var task:Task? {get set}
    //var value:Any? {get set}
}


public struct InPort<T>:Port {
    public var number:PortNumber
    public var task:Task?
    public var identifier:String? = nil
    public var desc:String? = nil
    var value:T? {
        get {
            return task?.portValue(number) as? T
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
    var value:Any? = nil
    
    init (task:Task? = nil) {
        self.task = task
    }
}


