import UIKit

func greet(person: String) -> String {
  return "Hello, " + person + "!"
}

print(greet(person: "Anna"))
print(greet(person: "Sunny"))


// Functions Without Parameters
func sayHelloWorld() -> String {
  return "Hello World!"
}
print(sayHelloWorld())


func printAndCount(string: String) -> Int {
  print(string)
  return string.count
}

func printWithoutCounting(string: String) {
  let _ = printAndCount(string: string)
}

printAndCount(string: "Hello?")
printWithoutCounting(string: "World?")

func minMax(array: [Int]) -> (min: Int, max: Int) {
  var currentMin = array[0]
  var currentMax = array[0]
  for value in array[1..<array.count] {
    if value < currentMin {
      currentMin = value
    } else if value > currentMax {
      currentMax = value
    }
  }
  return (currentMin, currentMax)
}
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min), max is \(bounds.max)")


// Specifying Argument Labels
func someFunctions(argumentLabel paramterName: Int) {
  print(paramterName)
}
someFunctions(argumentLabel: 2)

func greet2(person: String, from hometown: String) -> String {
  let returnString = "\(person) is from \(hometown)"
  print(returnString)
  return returnString
}
greet2(person: "Sunny", from: "Taipei")


// Omitting Argument Labels
func someFunction2(_ first: Int, second: Int) {
}
someFunction2(1, second: 2)

// Default Parameter Values
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
}


// Variadic Parameters
func arithmeticMean(_ numbers: Double...) -> Double {
  var total: Double = 0
  for number in numbers {
    total += number
  }
  print(total / Double(numbers.count))
  return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5) // 3.0
arithmeticMean(3, 8.25, 18.75) // 10.0



// In-Out Parameters
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
  let temporaryA = a
  a = b
  b = temporaryA
}
var inta = 1
var intb = 2
swapTwoInts(&inta, &intb)
print("inta is now \(inta), intb is now \(intb)")
// 输入输出形式参数与函数的返回值不同。上边的 swapTwoInts没有定义返回类型和返回值，但它仍然能修改 someInt和 anotherInt的值。输入输出形式参数是函数能影响到函数范围外的另一种替代方式。



func addTwoInt(_ a: Int, _ b: Int) -> Int { // (Int, Int) -> Int
  return a + b
}
addTwoInt(1, 2)
func multiplyTwoInt(_ a: Int, _ b: Int) -> Int { // (Int, Int) -> Int
  return a * b
}
multiplyTwoInt(1, 2)


func printHelloWorld() { // () -> void
  print("hello, world")
}

// Using Function Types

var mathFunctions: (Int, Int) -> Int = addTwoInt
// “定义一个叫做 mathFunction的变量，它的类型是‘一个能接受两个 Int值的函数，并返回一个 Int值。’将这个新的变量指向 addTwoInts函数。”
print("Result: \(mathFunctions(2, 3))")
let anotherMath = addTwoInt

// Function Types as Parameter Types
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
  print("Result is \(mathFunctions(a, b))")
}
printMathResult(addTwoInt, 5, 8)


// Function Types as Return Types

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
  // Nested Functions
  func stepForward(_ input: Int) -> Int {
    return input + 1
  }
  func stepBackward(_ input: Int) -> Int {
    return input - 1
  }
  return backward ? stepBackward : stepForward
}
var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
while currentValue != 0 {
  print("\(currentValue)...")
  currentValue = moveNearerToZero(currentValue)
}
print("zero!")



