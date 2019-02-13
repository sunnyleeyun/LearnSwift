import UIKit


/* 数值型字面量 Numeric Literals
一个十进制数 decimal ，没有前缀
一个二进制数 binary ，前缀是 0b
一个八进制数 octal ，前缀是 0o
一个十六进制数 hexadecimal，前缀是 0x
 */

let decimalInteger = 17
let binaryInteger = 0b1001
let octalInteger = 0o21
let hexadecimalInteger = 0x11

let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0

let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

/*
Int8 : -129 ~ 127
UInt8 : 0 ~ 255
*/

/* 类型别名 Type Aliases */
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min

/* 元組 Tuple */
let http404Error = (404, "Not Found")
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")

let (justStatusCode, _) = http404Error
print("Just Status Code is \(justStatusCode)")
print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")

let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
print("The status message is \(http200Status.description)")

/* 可選項 Optional */
// 在 C 和 Objective-C 中，没有可选项的概念。在 Objective-C 中有一个近似的特性，一个方法可以返回一个对象或者返回 nil 。 nil 的意思是“缺少一个可用对象”。然而，他只能用在对象上，却不能作用在结构体，基础的 C 类型和枚举值上。对于这些类型，Objective-C 会返回一个特殊的值（例如 NSNotFound ）来表示值的缺失。这种方法是建立在假设调用者知道这个特殊的值并记得去检查他。然而，Swift 中的可选项就可以让你知道任何类型的值的缺失，他并不需要一个特殊的值。

var serverResponseCode: Int? = 404
serverResponseCode = nil

var serverAnswer: String? // Automatically set to "nil"
// Swift 中的 nil 和Objective-C 中的 nil 不同，在 Objective-C 中 nil 是一个指向不存在对象的指针。在 Swift中， nil 不是指针，他是值缺失的一种特殊类型，任何类型的可选项都可以设置成 nil 而不仅仅是对象类型。


/* 隐式展开可选项  Implicitly Unwrapped Optionals */
let possibleString: String? = "An optional string"
let forcedString: String = possibleString!

let assumedString: String! = "An implicity unwrapped optional string"
let implicitString: String = assumedString


/* 错误处理 Error Handling */

func canThrowAnError() throws {
  
}
do {
  try canThrowAnError()
  // no error has thrown
} catch {
  // an error has thrown
}


func makeASandwich() throws {
  
}

do {
  try makeASandwich()
  // eatASandwich()
} catch { //Error.OutOfCleanDishes
  // washDishes()
} catch { // Error.MissingIngredients(let ingredients)
  // buyGroceries(ingredients)
}


/* 断言和先决条件 Assertions and Preconditions */
let age = 10

if age > 10 {
  print("You can ride the roller-coaster or the ferris wheel.")
} else if age > 0 {
  print("You can ride the ferris wheel.")
} else {
  assertionFailure("A person's age can't be less than zero.")
}

let index = 1
precondition(index > 0, "Index must be greater than zero.")
