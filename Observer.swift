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
    private var lock:OSSpinLock = OS_SPINLOCK_INIT
    var willSetObservers = Array<(T, T) -> ()>()
    var didSetObservers = Array<(T, T) -> ()>()
    var raw : T {
        willSet {
            let list = willSetObservers
            for closure in list {
                closure(newValue, self.raw)
            }
        }
        
        didSet {
            let list = didSetObservers
            for closure in list {
                closure(self.raw, oldValue)
            }
        }
    }
    
    init(_ value : T) {
        raw = value
    }
    
    mutating func addObserver(type: ObservingType, closure : (T, T) -> ()) {
        OSSpinLockLock(&self.lock)
        switch type {
        case .WillSet:
            willSetObservers.append(closure)
        case .DidSet:
            didSetObservers.append(closure)
        }
        OSSpinLockUnlock(&self.lock)
    }
}
