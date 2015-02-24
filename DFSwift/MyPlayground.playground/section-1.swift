// Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

var s:Array<Int>

func invoke<T>(x:T, f:(T)->(T)) -> T {
    return f(x)
}

var x = invoke(2) {(x:Int) in
    return x
}

public func curry<T>(f:()->(T))-> ()->(T) {
    return f
}

public func curry<T1, T>(f:(T1)->(T))-> (T1)->(T) {
    return f
}

public func curry<T1, T2, T>(f:(T1, T2)->(T))-> (T1)->(T2)->(T) {
    return {(x1:T1) in
        return {(x2:T2) in
             return f(x1, x2)
        }
    }
}

public func curry<T1, T2, T3, T>(f:(T1, T2, T3)->(T))-> (T1)->(T2)->(T3)->(T) {
    return {(x1:T1) in
        return {(x2:T2) in
            return {(x3:T3) in
                return f(x1,x2,x3)
            }
        }
    }
}

public func curry<T1, T2, T3, T4, T>(f:(T1, T2, T3, T4)->(T))-> (T1)->(T2)->(T3)->(T4)->(T) {
    return {(x1:T1) in
        return {(x2:T2) in
            return {(x3:T3) in
                return {(x4:T4) in
                    return f(x1,x2,x3, x4)
                }
            }
        }
    }
}

public func curry<T1, T2, T3, T4, T5, T>(f:(T1, T2, T3, T4, T5)->(T))-> (T1)->(T2)->(T3)->(T4)->(T5)->(T) {
    return {(x1:T1) in
        return {(x2:T2) in
            return {(x3:T3) in
                return {(x4:T4) in
                    return {(x5:T5) in
                        return f(x1,x2,x3, x4, x5)
                    }
                }
            }
        }
    }
}

class Test {
    func sum(x:Int,_ y:Int) -> Int {
        return x + y
    }
}


func sum(x:Int, y:Int) -> Int {
    return x + y
}

func product(x:Int,y:Int) -> Int {
    return x * y
}

var a = Test.sum
var b = curry(a)
var c = Test()
var d = b(c)
var e = curry(d)
var f = e(10)
var g = f(10)
var h = curry(sum)(10)(40)


var pr:(opt1:Int, opt2:Int) -> Int
var pr1:(opt1:Bool, opt2:Bool) -> Bool


