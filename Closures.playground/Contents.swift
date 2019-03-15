import UIKit


 /*
 - 全局函数是一个有名字但不会捕获任何值的闭包；
 - 内嵌函数是一个有名字且能从其上层函数捕获值的闭包；
 - 闭包表达式是一个轻量级语法所写的可以捕获其上下文中常量或变量值的没有名字的闭包。
 */

/* 閉包表達式: 闭包表达式是一种在简短行内就能写完闭包的语法。闭包表达式为了缩减书写长度又不失易读明晰而提供了一系列的语法优化。*/
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(s1: String, s2: String) -> Bool {
  return s1 > s2
}

var reversedName = names.sorted(by: backward)

 /* 闭包表达式语法 */
 /*
 { (parameters) -> (return type) in
    statements
 }
 */

reversedName = names.sorted(by: { (s1: String, s2: String) -> Bool in
  return s1 > s2
})
reversedName = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })
reversedName = names.sorted(by: { s1, s2 in return s1 > s2 })
reversedName = names.sorted(by: { s1, s2 in s1 > s2 })
reversedName = names.sorted(by: { $0 > $1 })
reversedName = names.sorted(by: >)




/*
 /* 尾随闭包 */
 func someFunctionThatTakesClosure(closure: () -> Void) {
 // function body goes here
 }
 
 /
 // here's how you call this function without using a trailing closure
 someFunctionThatTakesClosure ({
 // closure's body goes here
 })
 // here's how you call this function with a trailing closure instead
 someFunctionThatTakesClosure() {
 // trailing closure's body goes here
 }
 */


reversedName = names.sorted() { $0 > $1 }
reversedName = names.sorted { $0 > $1 }

let digitNames = [
  0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
  5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
  var number = number
  var output = ""
  repeat {
    output = digitNames[number % 10]! + output
    number /= 10
  } while number > 0
  return output
}

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
  var runningTotal = 0
  func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
  }
  return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementByTen()    //return a value of 10
incrementByTen()    //return a value of 20
incrementByTen()    //return a value of 30
incrementBySeven()  // return a value of 7
incrementByTen()    // return a value of 40


/* 闭包是引用类型 (Reference Types) */
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen() // return a value of 50


/* 逃逸闭包 */
/* 当闭包作为一个实际参数传递给一个函数的时候，我们就说这个闭包逃逸了，因为它可以在函数返回之后被调用。 @escaping */
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
  completionHandlers.append(completionHandler)
}
func someFunctionWithNonEscapingClosure(closure: () -> Void) {
  closure()
}

class SomeClass {
  var x = 10
  func doSomething() {
    someFunctionWithEscapingClosure { self.x = 100 }
    someFunctionWithNonEscapingClosure { x = 200 }
  }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)


/* 自动闭包 */
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5"

print("Now serving \(customerProvider())")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"


// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
  print("Now serving \(customerProvider())")
}
serve(customer: { customersInLine.remove(at: 0)} )
// Prints "Now serving Alex!"


// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
  print("Now serving \(customerProvider())")
}
serve(customer: customersInLine.remove(at: 0))
// Prints "Now serving Ewa!"


// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
  customerProviders.append(customerProvider)
}

collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
// print "Collected 2 closures."
for customerProvider in customerProviders {
  print("Now serving \(customerProvider())")
}
// Prints "Now serving Barry!"
// Prints "Now serving Daniella!"

