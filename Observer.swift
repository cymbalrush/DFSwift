//
//  Observer.swift
//  DFSwift
//
//  Created by Sinha, Gyanendra on 2/9/15.
//  Copyright (c) 2015 Sinha, Gyanendra. All rights reserved.
//

import Foundation

public enum ObservingType : Int {
    case WillSet = 0, DidSet
}

public struct Observable<T> {
    var raw : T {
        willSet {
            if let list = observingInfo[.WillSet] {
            
                for closure in list {
                    closure(newValue, self.raw)
                }
            }
        }
        
        didSet {
            if let list = observingInfo[.DidSet] {
                for closure in list {
                    closure(self.raw, oldValue)
                }
            }
        }
    }
    
    init(_ value : T) {
        self.raw = value
        observingInfo[.WillSet] = Array<(T, T) -> ()>()
        observingInfo[.DidSet] = Array<(T, T) -> ()>()
    }
    
    var observingInfo = [ObservingType : Array<(T, T) -> ()>]()
    
    mutating func addObserver(type: ObservingType, closure : (T, T) -> ()) {
        var expandedArray : Array<(T, T) -> ()> = observingInfo[type]!
        expandedArray.append(closure)
        observingInfo[type] = expandedArray
    }
    
    func __conversion() -> T {
        return raw
    }
}
