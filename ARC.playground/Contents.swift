// ARC 정리 말로 설명할 수 있을때 까지.
// ARC 는 앱의 메모리 사용을 관리하는 요소이다. 메모리 영역으로 클래스 인스턴스만 유의하여 사용하면 된다.

class Person0 {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person0?
var reference2: Person0?
var reference3: Person0?

reference1 = Person0(name: "John 0") // John Appleseed is being initialized
reference2 = reference1
reference3 = reference1 // reference1 의 참조카운트는 현재 3

reference1 = nil
reference2 = nil
reference3 = nil // Person(name: "John Appleseed") 메모리에서 해지
// John Appleseed is being deinitialized


// 클래스 인스턴스간의 강한 참조

class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment? // Apartment 인스턴스 strong 참조 arc의 횟수 1증가
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person? // Person 인스턴스 arc strong 참조 횟수 1 증가
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A // john은 현재 2의 참조카운트
unit4A!.tenant = john // unit4A도 현재 2의 참조카운트

john = nil // unit4A의 tenant 변수에 strong 으로 참조되어있음
unit4A = nil // john의 apartment 변수에 strong 으로 참조되어있음


// weak를 통한 해결
class Person1 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment1? // Apartment 인스턴스 strong 참조 arc의 횟수 1증가
    deinit { print("\(name) is being deinitialized") }
}

class Apartment1 {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person1? // Person 인스턴스 arc strong 참조 횟수 1 증가 // 아파트에는 세입자가 없는 상태일 수 있기 때문에 -> 참조되고 있는 인스턴스가 참조하고 있는 인스턴스보다 먼저 해지될때
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john1: Person1?
var unit4A1: Apartment1?

john1 = Person1(name: "John 1")
unit4A1 = Apartment1(unit: "4A 1")

john1!.apartment = unit4A1 // unit4A도 현재 2의 참조카운트
unit4A1!.tenant = john1 //

john1 = nil // unit4A의 tenant 변수에 weak로 참조되어있음
unit4A1 = nil // john의 apartment 변수에 참조되어있다. john이 사라지면서 참조카운트가 다시 감소했다.


// unowned를 통한 해결
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer // 카드의 개념에서 카드는 없어져도 사람은
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

var jeong: Customer?
jeong = Customer(name: "jeong")

jeong!.card = CreditCard(number: 2_2222_2222, customer: jeong!)
jeong = nil


class HTMLElement {
    let name: String
    let text: String?
    lazy var asHTML: () -> String = {
        [unowned self] in
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
