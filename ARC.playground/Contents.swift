import UIKit

// https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html
// https://www.cnswift.org/automatic-reference-counting

class Person {
  let name: String
  init(name: String) {
    self.name = name
    print("\(name) is being initialized")
  }
  deinit {
    print("\(name) is being deinitialized")
  }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "Sunny Lee")
/*
注意，当调用 person 类的出初始化器的时候，会输出 "Sunny Lee is being initialized" 信息。这就说明初始化执行了。
因为 Person 实例已经赋值给了 reference1 变量，现在就有了一个从 reference1 到该实例的强引用。因为至少有一个强引用，ARC可以确保 Person 一直保持在内存中不被销毁。
*/

reference2 = reference1
reference3 = reference1
/* 现在这一个 Person 实例就有了三个强引用。 */

reference1 = nil
reference2 = nil
/* 只留下一个强引用， Person 实例不会被销毁 */

reference3 = nil
/* 直到第三个也就是最后一个强引用被断开时 ARC 会销毁它，輸出 "Sunny Lee is being deinitialized" */

class PersonApartment {
  let name: String
  init(name: String) {
    self.name = name
  }
  var apartment: Apartment?
  deinit {
    print("\(name) is being deinitialized")
  }
}

class Apartment {
  let unit: String
  init(unit: String) {
    self.unit = unit
  }
  weak var tenant: PersonApartment? // >>> var tenant: PersonApartment?
  deinit {
    print("Apartment \(unit) is being deinitialized")
  }
}

var sunny: PersonApartment?
var unit4A: Apartment?

sunny = PersonApartment(name: "sunny")
unit4A = Apartment(unit: "4A")

sunny?.apartment = unit4A
unit4A?.tenant = sunny

sunny = nil /* >>> Sunny Lee is being deinitialized */
unit4A = nil /* >>> Apartment 4A is being deinitialized */
/*
注意，当你把这两个变量设为 nil 时，没有任何一个反初始化器被调用。
循环强引用会一直阻止 Person 和 Apartment 类实例的释放，这就在你的应用程序中造成了内存泄漏。
*/

/* 解决实例之间的循环强引用: 弱引用（ weak reference ）和无主引用（ unowned reference )。 */
/* 在实例的生命周期中，当引用可能“没有值”的时候，就使用弱引用 ( weak reference ) 来避免循环引用。 */
/* 弱引用 ( weak reference ) 為 variable，因當引用的實例被釋放，自動設置弱引用為 nil */

class Customer {
  let name: String
  var creditCard: CreditCard?
  init(name: String) {
    self.name = name
  }
  deinit {
    print("\(name) is being deinitialized")
  }
}

class CreditCard {
  let number: UInt64
  unowned let customer: Customer
  init(number: UInt64, customer: Customer) {
    self.number = number
    self.customer = customer
  }
  deinit {
    print("Card #\(number) is being deinitialized")
  }
}
var sunnyCustomer: Customer?
sunnyCustomer = Customer(name: "Sunny Lee")
sunnyCustomer?.creditCard = CreditCard(number: 1234_5678_9012_3456, customer: sunnyCustomer!)
/*
现在 Customer 实例对 CreditCard 实例有一个强引用(strong)，
并且 CreditCard 实例对 Customer 实例有一个无主引用(unowned)。
*/
sunnyCustomer = nil
// prints "Sunny Lee is being deinitialized"
// prints "Card #1234567890123456 is being deinitialized"

class Country {
  let name: String
  var capitalCity: City!
  init(name: String, capitalName: String) {
    self.name = name
    self.capitalCity = City(name: capitalName, country: self)
  }
}

class City {
  let name: String
  unowned let country: Country
  init(name: String, country: Country) {
    self.name = name
    self.country = country
  }
}

/*
两段式初始化
由于 capitalCity 默认值为 nil ，一旦 Country 的实例在初始化器中给 name 属性赋值后，整个初始化过程就完成了。
这意味着一旦 name 属性被赋值后， Country 的初始化器就能引用并传递隐式的 self 。
Country 的初始化器在赋值 capitalCity 时，就能将 self 作为参数传递给 City 的初始化器。
*/

var country = Country(name: "Taiwan", capitalName: "Taipei")
print("\(country.name)'s capital is called \(country.capitalCity.name).")


class HTMLElement {
  let name: String
  let text: String?
  
  lazy var asHTML: () -> String = {
    [unowned self] in // <<<
    if let text = self.text {
      return "<\(self.name)>\(text)</\(self.name)>"
    } else {
      return "<\(self.name) />"
    }
  }
  
  init(name: String, text: String? = nil) {
    self.name = name
    self.text = text
  }
  
  deinit {
    print("\(name) is being deinitialized")
  }
  
}

let heading = HTMLElement(name: "h1")
let defaultText = "Some default text"
heading.asHTML = {
  return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "Hello world!")
print(paragraph!.asHTML())
paragraph = nil
/* 注意 HTMLElement 的反初始化器中的消息并没有被打印，证明了 HTMLElement 实例并没有被销毁。*/
