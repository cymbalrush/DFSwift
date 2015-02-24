//
//  Operators.swift
//  DFSwift
//
//  Created by Sinha, Gyanendra on 2/11/15.
//  Copyright (c) 2015 Sinha, Gyanendra. All rights reserved.
//

public func ~><T1, T>(task:DFTask<T1>, tuple:(InPort<T1>, Port1,  DFTask1<T1, T>)) -> DFTask1<T1, T> {
    return tuple.2.connect(task, number:PORT1)
}

public func ~><T1, T2, T >(task:DFTask<T2>, tuple:(InPort<T2>, Port2, DFTask2<T1, T2, T>)) -> DFTask2<T1, T2, T> {
    return tuple.2.connect(task, number: PORT2)
}

public func ~><T1, T2, T3, T>(task:DFTask<T3>, tuple:(InPort<T3>, Port3, DFTask3<T1, T2, T3, T>)) -> DFTask3<T1, T2, T3, T> {
    return tuple.2.connect(task, number: PORT3)
}

public func ~><T1, T2, T3, T4, T>(task:DFTask<T4>, tuple:(InPort<T4>, Port4, DFTask4<T1, T2, T3, T4, T>)) -> DFTask4<T1, T2, T3, T4, T> {
    return tuple.2.connect(task, number: PORT4)
}
