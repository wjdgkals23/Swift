import UIKit

var str = "Hello, playground"

struct SomeStruct {
    var property: String = "String"
}

func copyStruct(localStruct: SomeStruct) -> Void {
    var here: SomeStruct = localStruct
    here.property = "ABC"
    print(here)
}

var here2: SomeStruct = SomeStruct()
copyStruct(localStruct: here2)
print(here2)

// closure

let sum: (Int, Int) -> Int = { (a:Int, b:Int) in
    return a+b
}

let subtract: (Int, Int) -> Int = { (a:Int, b:Int) in
    return a-b
}

let mulitiple: (Int, Int) -> Int = { (a:Int, b:Int) -> Int in
    return a*b
}

let divide: (Int, Int) -> Int = { (a:Int, b:Int) -> Int in
    return a/b
}

func calculate(_ a:Int, _ b:Int, function: (Int,Int) -> Int) -> Int {
    return function(a,b)
}

print(calculate(3, 4, function: sum))
print(calculate(4, 5, function: { (a:Int, b:Int) -> Int in
    return Int(sqrt(Double(a)))
}))

//클로저는 아래 규칙을 통해 다양한 모습으로 표현될 수 있습니다.
//
//후행 클로저 : 함수의 매개변수 마지막으로 전달되는 클로저는 후행클로저(trailing closure)로 함수 밖에 구현할 수 있습니다.
//반환타입 생략 : 컴파일러가 클로저의 타입을 유추할 수 있는 경우 매개변수, 반환 타입을 생략할 수 있습니다.
//단축 인자 이름 : 전달인자의 이름이 굳이 필요없고, 컴파일러가 타입을 유추할 수 있는 경우 축약된 전달인자 이름($0, $1, $2...)을 사용 할 수 있습니다.
//암시적 반환 표현 : 반환 값이 있는 경우, 암시적으로 클로저의 맨 마지막 줄은 return 키워드를 생략하더라도 반환 값으로 취급합니다.

calculate(4,5) {
    $0 + $1
}

print(calculate(2, 3, function: mulitiple))


// 프로퍼티
//인스턴스 저장 프로퍼티
//타입 저장 프로퍼티
//인스턴스 연산 프로퍼티
//타입 연산 프로퍼티

struct Money {
    //인스턴스 저장 프로퍼티
    var currencyRate: Double = 1100
    var dollar: Double = 0
    //인스턴스 연산 프로퍼티
    var won: Double {
        get {
            return dollar * currencyRate
        }
        set {
            self.dollar = newValue/currencyRate
        }
    }
    
    //타입 저장 프로퍼티
    static var saveproper = 12 {
        willSet(newRate) {
            print("새로 할당될 환율은 다음과 같습니다. \(newRate)")
        }
        didSet(oldRate) {
            print("기존 환율은 다음과 같습니다. \(oldRate)")
        }
    }
    
    static var calproper: Int {
        get {
            return saveproper
        }
        set {
            self.saveproper = newValue
        }
    }
}

var te = Money()
te.won = 11000
print(te.dollar)
print(Money.calproper)
Money.calproper = 22
print(Money.saveproper)



// class 상속
//final 키워드를 사용하면 재정의(override)를 방지할 수 있습니다.
//static 키워드를 사용해 타입 메서드를 만들면 재정의가 불가능 합니다.
//class 키워드를 사용해 타입 메서드를 만들면 재정의가 가능합니다.
//class 앞에 final을 붙이면 static 키워드를 사용한것과 동일하게 동작합니다.
//override 키워드를 사용해 부모 클래스의 메서드를 재정의 할 수 있습니다.

class Person{
    var name: String = ""
    
    func selfIntroduce() {
        print("저는 \(name) 입니다")
    }
    
    final func sayHello(){
        print("Hello")
    }
    
    static func typeMethod(){
        print("type method - static")
    }
    
    class func classMethod(){
        print("type method - class")
    }
    
    final class func finalClassMethod(){ // final class == static
        print("type method - final class")
    }
}

class Student: Person {
    var major: String = ""
    
    override func selfIntroduce() {
        print("저의 전공은 \(major) 이름은 \(name)")
    }
    
    override class func classMethod(){
        print("override type method - class")
    }
}

let hamin = Student()
hamin.name = "hamin"
hamin.major = "computer"
hamin.selfIntroduce()
Student.classMethod()


// 인스턴스 생성자와 소멸자
class Pet {
    var name: String? = ""
    var owner: Person!
    
    init?(name: String?) {
        if let temp = name {
            self.name = temp
        }
    }
    
    func goOut() {
        print("산책 주인\(owner.name)")
    }
}

class PersonB {
    var name: String
    var age: Int
    var pet: Pet?
    var child: Person?
    
    // 이니셜라이저
    convenience init?(name: String, age: Int, pet: Pet?, child: Person?) {
        self.init(name: name, age: age)
        if let t_pet = pet {
            self.pet = t_pet
        } else{
            self.pet = nil
        }
        if let t_chi = child {
            self.child = t_chi
        } else{
            self.child = nil
        }
    }
    
    init?(name: String, age: Int) {
        if(0...120).contains(age)==false {
            return nil
        }
        
        self.name = name
        self.age = age
    }
    
    deinit {
        if let d_pet = self.pet {
            d_pet.owner = self.child
        }
    }
}

let pp = Pet(name: "dog")
let chi = Person()
chi.name = "heamin"
var god:PersonB? = PersonB(name: "god", age: 22, pet: pp, child: chi)
god = nil

if let ow = pp?.owner {
    print(ow.name)
}

