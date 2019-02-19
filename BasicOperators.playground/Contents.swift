import UIKit

let b = 10
var a = 5
a = b // a 的值现在是 10

let (x, y) = (1, 2) // x 等于 1, 同时 y 等于 2

 /*
 if x = y {
 // 这是不合法的, 因为 x = y 并不会返回任何值。
 }
 */

let three = 3
let minusThree = -three
let plusThree = -minusThree

let minusSix = -6
let alsoMinusSix = +minusSix

var c = 1
c += 2
/* 组合运算符不会返回任何值。举例来说，你不能写成这样 let b = a += 2  。这个与前边提到的增量和减量符号的行为不同。 */

let name = "world"
if name == "world" {
  print("hello, world")
} else {
  print("I'm sorry \(name), but I don't recognize you.")
}

(1, "zebra") < (2, "apple")
(3, "apple") < (3, "bird")
(4, "dog") == (4, "dog")
/* ("blue", false) < ("purple", true) // Error because < can't compare Boolean values */

/* Ternary Conditional Operator 三元運算子*/
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)

/* 合并空值运算符是此代码的缩写： a != nil ? a! : b */

let defaultColorName = "red"
var userDefinedColorName: String? // defaults to nil
var colorNameToUse = userDefinedColorName ?? defaultColorName

/* Closed Range Operator */
for index in 1...5 {
  print("\(index) time 5 equals to \(index * 5)")
}

/* Half-Open Range Operator */
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
  print("Person \(i+1) is called \(names[i])")
}

/* One-Sided Range */
for name in names[2...] {
  print(name)
}
// Brian
// Jack

for name in names[...2] {
  print(name)
}
// Anna
// Alex
// Brian

// half-open range operator also has a one-sided form
for name in names[..<2] {
  print(name)
}
// Anna
// Alex

let range = ...5
range.contains(7)
range.contains(4)
range.contains(-1)


/*
 Logical NOT (!a)
 Logical AND (a && b)
 Logical OR (a || b)
 */


let allowEntry = false
if !allowEntry {
  print("Not Allow Entry")
}

let enteredDoorCode = true
let passedRetinaCode = false

if enteredDoorCode && passedRetinaCode {
  print("Welcome!")
} else {
  print("ACCESS DENIED!")
}


let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
  print("Welcome!")
} else {
  print("ACCESS DENIED")
}

if enteredDoorCode && passedRetinaCode || hasDoorKey || knowsOverridePassword {
  print("Welcome!")
} else {
  print("ACCESS DENIED")
}

/* 很多时候虽然不被要求，但使用括号还是很有用的，这能让复杂的表达式更容易阅读。 */
if (enteredDoorCode && passedRetinaCode) || hasDoorKey || knowsOverridePassword {
  print("Welcome!")
} else {
  print("ACCESS DENIED")
}
