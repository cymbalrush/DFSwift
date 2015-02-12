//
//  Utility.swift
//  DFSwift
//
//  Created by Sinha, Gyanendra on 2/11/15.
//  Copyright (c) 2015 Sinha, Gyanendra. All rights reserved.
//

import Foundation

class Spinlock {
    private var _lock : OSSpinLock = OS_SPINLOCK_INIT
    
    func around(closure: Void -> Void) {
        OSSpinLockLock(&self._lock)
        closure()
        OSSpinLockUnlock(&self._lock)
    }
    
    func around<T>(closure: Void -> T) -> T {
        OSSpinLockLock(&self._lock)
        let result = closure()
        OSSpinLockUnlock(&self._lock)
        return result
    } 
}