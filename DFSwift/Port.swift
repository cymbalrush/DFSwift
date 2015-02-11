//
//  DFPort.swift
//  DFSwift
//
//  Created by Sinha, Gyanendra on 2/5/15.
//  Copyright (c) 2015 Sinha, Gyanendra. All rights reserved.
//

import Foundation

protocol PortNumber:Printable {}

enum PortNumber1:Int, PortNumber, Printable  {
    case Port1 = 1
    
    var description:String {
        return "PORT_1"
    }
    
    func toString() -> String {
        return description
    }
}

enum PortNumber2:Int, PortNumber {
    case Port2 = 2
    
    var description:String {
        return "PORT_2"
    }
    
    func toString() -> String {
        return description
    }
}

enum PortNumber3:Int, PortNumber {
    case Port3 = 3
    
    var description:String {
        return "PORT_3"
    }
    
    func toString() -> String {
        return description
    }
}

enum PortNumber4:Int, PortNumber {
    case Port4 = 4
    
    var description:String {
        return "PORT_4"
    }
    
    func toString() -> String {
        return description
    }
}

enum PortNumber5:Int, PortNumber {
    case Port5 = 5
    
    var description:String {
        return "PORT_5"
    }
    
    func toString() -> String {
        return description
    }
}

enum PortNumber6:Int, PortNumber {
    case Port6 = 6
    
    var description:String {
        return "PORT_6"
    }
    
    func toString() -> String {
        return description
    }
}

enum PortNumber7:Int, PortNumber {
    case Port7 = 7
    
    var description:String {
        return "PORT_7"
    }
    
    func toString() -> String {
        return description
    }
}

enum PortNumber8:Int, PortNumber {
    case Port8 = 8
    
    var description:String {
        return "PORT_8"
    }
    
    func toString() -> String {
        return description
    }
}

enum PortNumber9:Int, PortNumber {
    case Port9 = 9
    
    var description:String {
        return "PORT_9"
    }
    
    func toString() -> String {
        return description
    }
}

enum PortNumber10:Int, PortNumber {
    case Port10 = 10
    
    var description:String {
        return "PORT_10"
    }
    
    func toString() -> String {
        return description
    }
}

protocol Port {
    var identifier:String? {get set}
    var desc:String? {get set}
    var task:Task? {get set}
    //var value:Any? {get set}
}

struct InPort<T>:Port {
    var number:PortNumber
    var task:Task?
    var identifier:String? = nil
    var desc:String? = nil
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

struct OutPort<T>:Port {
    var identifier:String? = nil
    var desc:String? = nil
    var value:Any? = nil
    var task:Task?
    
    init (task:Task? = nil) {
        self.task = task
    }
}


