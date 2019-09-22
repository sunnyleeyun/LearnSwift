import UIKit

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
  let temporaryA = a
  a = b
  b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// swapTwoInts is useful, but it can only be used in Int type

/* Generic function: swapTwoValues<T> */
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
  let temporaryA = a
  a = b
  b = temporaryA
}

// 它确实说了 a 和 b 必须都是同一个类型 T ，或者说都是 T 所表示的类型。替代 T 实际使用的类型将在每次调用 swapTwoValues(_:_:) 函数时决定。

var someIntAgain = 3
var anotherIntAgain = 107
swapTwoValues(&someIntAgain, &anotherIntAgain)
print("someIntAgain is now \(someIntAgain), and anotherIntAgain is now \(anotherIntAgain)")


var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
print("someString is now \(someString), and anotherString is now \(anotherString)")


// Generic Types are custom classes, structures, and enumerations that can work with any type, in a similar way to Array and Dictionary.

// This section shows stack

// Non-generic way
struct IntStack {
  var items = [Int]()
  mutating func push(_ item: Int) {
    items.append(item)
  }
  mutating func pop() -> Int {
    return items.removeLast()
  }
  
}

// Generic way
struct Stack<Element> {
  var items = [Element]()
  mutating func push(_ item: Element) {
    items.append(item)
  }
  mutating func pop() -> Element {
    return items.removeLast()
  }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
let fromTheTop = stackOfStrings.pop()

extension Stack {
  var topItem: Element? {
    return items.isEmpty ? nil : items[items.count-1]
  }
}

if let topItem = stackOfStrings.topItem {
  print("The top item on the stack is \(topItem)")
}

func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
  for (index, value) in array.enumerated() {
    if value == valueToFind {
      return index
    }
  }
  return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
  print("The index of llama is \(foundIndex)")
}



func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
  for (index, value) in array.enumerated() {
    if value == valueToFind {
      return index
    }
  }
  return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])


protocol Container {
  associatedtype ItemType
  mutating func append(_ item: ItemType)
  var count: Int { get }
  subscript(i: Int) -> ItemType { get }
}


struct IntStackCon: Container {
  // original IntStack implementation
  var items = [Int]()
  mutating func push(_ item: Int) {
    items.append(item)
  }
  mutating func pop() -> Int {
    return items.removeLast()
  }
  
  // conformance to the Container protocol
  typealias ItemType = Int
  mutating func append(_ item: Int) {
    self.push(item)
  }
  var count: Int {
    return items.count
  }
  subscript(i: Int) -> Int {
    return items[i]
  }
}

protocol StackContainer {
  associatedtype Item: Equatable
  mutating func append(_ item: Item)
  var count: Int { get }
  subscript(i: Int) -> Item { get }
}

//struct StackCon<Element>: StackContainer {
//  // original IntStack implementation
//  var items = [Element]()
//  mutating func push(_ item: Element) {
//    items.append(item)
//  }
//  mutating func pop() -> Element {
//    return items.removeLast()
//  }
//
//  // conformance to the Container protocol
//  mutating func append(_ item: Element) {
//    self.push(item)
//  }
//  var count: Int {
//    return items.count
//  }
//  subscript(i: Int) -> Element {
//    return items[i]
//  }
//}

