//
//  Observer.swift
//  DFSwift
//
//  Created by Sinha, Gyanendra on 2/9/15.
//  Copyright (c) 2015 Sinha, Gyanendra. All rights reserved.
//

import Foundation

public protocol ObservationToken {}

public enum ObservingType : Int {
    case WillSet = 0, DidSet
}

struct ObservationToken_:ObservationToken, Hashable {
    let uuid:NSUUID
    init () {
        uuid = NSUUID()
    }
    var hashValue:Int {
        return uuid.hashValue
    }
}

func ==(lhs: ObservationToken_, rhs: ObservationToken_) -> Bool {
    return lhs.uuid.isEqual(rhs.uuid)
}

public struct Observable<T> {
    private var lock:OSSpinLock = OS_SPINLOCK_INIT
    var willSetObservers = Dictionary<ObservationToken_, (T, T) -> ()>()
    var didSetObservers = Dictionary<ObservationToken_, (T, T) -> ()>()
    public var raw : T {
        willSet {
            let list = willSetObservers.values
            for closure in list {
                closure(newValue, self.raw)
            }
        }
        
        didSet {
            let list = didSetObservers.values
            for closure in list {
                closure(self.raw, oldValue)
            }
        }
    }
    
    public init(_ value : T) {
        raw = value
    }
    
    public mutating func addObserver(type: ObservingType, closure : (T, T) -> ()) -> ObservationToken {
        let token = ObservationToken_()
        OSSpinLockLock(&self.lock)
        switch type {
        case .WillSet:
            willSetObservers[token] = closure
        case .DidSet:
            didSetObservers[token] = closure
        }
        OSSpinLockUnlock(&self.lock)
        return token
    }
    
    public mutating func removeObserver(token:ObservationToken)-> ((T, T) -> ())? {
        let token = token as! ObservationToken_
        var closure:((T, T) -> ())? = nil
        OSSpinLockLock(&self.lock)
        closure = willSetObservers.removeValueForKey(token)
        if closure == nil {
            closure = didSetObservers.removeValueForKey(token)
        }
        OSSpinLockUnlock(&self.lock)
        return closure
    }
}
