//
//  Operators.swift
//  DFSwift
//
//  Created by Sinha, Gyanendra on 2/11/15.
//  Copyright (c) 2015 Sinha, Gyanendra. All rights reserved.
//

//infix operator ~> { associativity left precedence 140 } // 1

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