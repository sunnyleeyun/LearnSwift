import UIKit

enum CompassPoint {
  case north
  case south
  case east
  case west
}

enum Planet {
  case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionHead = CompassPoint.west
directionHead = .east

switch directionHead {
case .north:
  print("Lots of planets have a north")
case .south:
  print("Watch out of penguins")
case .east:
  print("Where the sun rises")
case .west:
  print("Where the skies are blue")
}
print(directionHead)

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
  print("Mostly harmless.")
default:
  print("Not safe for humans")
}


enum Beverage: CaseIterable {
  case coffee, tea, juice
}

let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages are available")

for bervage in Beverage.allCases {
  print(bervage)
}

enum Barcode {
  case upc(Int, Int, Int, Int)
  case qrCode(String)
}
// “定义一个叫做 Barcode的枚举类型，它要么用 (Int, Int, Int, Int)类型的关联值获取 upc 值，要么用 String 类型的关联值获取一个 qrCode的值。”

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = Barcode.qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
  print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
  print("QR Code: \(productCode)")
}
// Prints -> QR Code: ABCDEFGHIJKLMNOP

enum ASCIIControlCharacter: Character {
  case tab = "\t"
  case lineFeed = "\n"
  case carriageReturn = "\r"
}

enum Planets: Int {
  case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

enum CompassPoints: String {
  case north, south, east, west
}
let earthOrder = Planets.earth.rawValue // 3
let sunsetDirection = CompassPoints.west.rawValue // west


let possiblePlanet = Planets(rawValue: 7) // optional -> Planets?

let positionToFind = 11
if let somePlanets = Planets(rawValue: positionToFind) {
  switch somePlanets {
  case .earth:
    print("HELLO, it earth")
  default:
    print("Where the fuck is this planet. Gonna die here.")
  }
} else {
  print("No such planet man. At least not know for now.")
}



/* Recursive Enumerations 遞歸枚舉 */
enum ArithmeticExpression {
  case number(Int)
  indirect case addition(ArithmeticExpression, ArithmeticExpression)
  indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

/* Same as below
 indirect enum ArithmeticExpression {
  case number(Int)
  case addition(ArithmeticExpression, ArithmeticExpression)
  case multiplication(ArithmeticExpression, ArithmeticExpression)
 }
*/
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
  switch expression {
  case let .number(value):
    return value
  case let .addition(left, right):
    return evaluate(left) + evaluate(right)
  case let .multiplication(left, right):
    return evaluate(left) - evaluate(right)
  }
}
print(evaluate(product))
