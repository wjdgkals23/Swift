import UIKit

var str = "Hello, playground"
dump(str)

class Person {
    var name: String = "wjdgkals23"
    var age: Int = 25
}

let haminInfo: Person = Person()

dump(haminInfo)


let integer = 100
let floatPoint = 12.34
let apple:Character = "A"

print(type(of: integer))
print(type(of: floatPoint))
print(type(of: apple))
// 기본적으로 암묵적인 데이터 형변환이 불가능하다.

//Any : 모든 타입을 받을 수 있는 클래스
//AnyObject : 모든 클래스 타입을 지칭하는 프로토콜
//nil : "없음"

var str2: Any = "STring"
//let STring: String = str2

//String = nil // nil은 개발자가 의도적으로 할당할 수 없다.

// Dictionnary
var anyDic: Dictionary<String,Any> = [String:Any]()
anyDic["TEMP"] = 2
anyDic
anyDic["TEMP"] = nil
anyDic
anyDic["TEMP"] = 2
anyDic
anyDic.removeValue(forKey: "TEMP")
anyDic


//Set 는 유일한 value만을 담는다.
var integerSet: Set<Int> = Set<Int>()
integerSet.insert(1)
integerSet.insert(1)
integerSet.insert(1)
integerSet.insert(2)
integerSet
let setA: Set<Int> = [1, 2, 3, 4, 5]
let setB: Set<Int> = [3, 4, 5, 6, 7]

// 합집합
let union: Set<Int> = setA.union(setB)
type(of: union)
print(union)

let sortedUnion: [Int] = union.sorted()



// func

//가변 매개변수
//전달 받을 값의 개수를 알기 어려울 때 사용합니다.
//가변 매개변수는 함수당 하나만 가질 수 있습니다.
//기본값이 있는 매개변수와 같이 가변 매개변수 역시 매개변수 목록 중 뒤쪽에 위치하는 것이 좋습니다.

//전달인자 레이블(Argument Label)
//함수를 호출할 때 함수 사용자의 입장에서 매개변수의 역할을 좀 더 명확하게 표현하고자 할 때 사용합니다.
//전달인자 레이블은 변경하여 동일한 이름의 함수를 중복으로 생성가능합니다.
func greeting(friend: String, me: String) {
    print("Hello \(friend)! I'm \(me)")
}


func greeting(to friend: String, from me: String) {
    print("Hello \(friend)! I'm \(me)")
}


// ## 함수는 일급객체
var someFunction: (String,String) -> Void = greeting(to:from:)
someFunction("eric","yagom")
someFunction = greeting(friend:me:)
someFunction("eric","yagom")

func runAnothter(function: (String,String)-> Void) {
    function("jenny","hamin")
}

runAnothter(function: greeting(to:from:))


// switch 패턴
let point = (4,4)
switch point {
// Bind x and y to the elements of point.
case (1...3, 4...6):
    print("The point is at (\(point.0), \(point.1)).")
case (3...5, 3...5):
    print("The value is at \(point.0)");
default:
    print("Anything can't match")
}


//Optional 열거형 데이터이며 없을 시 nil을 반환한다.

//! 추출 옵션 !를 통해 생성된 옵셔널은 기초형들로 추출(암묵적 추출)이 가능하여 기초형들과 연산이 가능하다.
var optionalValue: Int! = 100

switch optionalValue {
case .none:
    print("None")
case .some(let value):
    print(value)
default:
    print("DEFAULT")
}

//? 추출을 어떻게 할까?
var optionalValue2: Int? = nil

switch optionalValue2 {
case .none:
    print("nil")
case .some(let value):
    print(value)
default:
    print("DEFAULT")
}

// 옵셔널바인딩 -> nil 체크 + 안전한 추출 : if let // 옵셔널 변수의 값은 if let 내에서만 사용가능
func printName(_ name: String) {
    print(name)
}

var myName: String? = nil

if let name: String = myName {
    printName(name)
} else {
    print("NIL")
}

var yourName: String! = nil

if let name: String = yourName {
    printName(name)
} else {
    print("yourName == nil")
}

// name 상수는 if-let 구문 내에서만 사용가능합니다
// 상수 사용범위를 벗어났기 때문에 컴파일 오류 발생
//printName(name)


// ,를 사용해 한 번에 여러 옵셔널을 바인딩 할 수 있습니다
// 모든 옵셔널에 값이 있을 때만 동작합니다
myName = "yagom"
yourName = nil

if let name = myName, let friend = yourName {
    print("\(name) and \(friend)")
}
// yourName이 nil이기 때문에 실행되지 않습니다
yourName = "hana"

if let name = myName, let friend = yourName {
    print("\(name) and \(friend)")
}


let temp: String! = "temp"
print(temp + "ee")
print(temp!)

let temp2: String? = "temp"
//print(temp2 + "3#") 암시적 옵셔널 추출방식이 가능하지 않은 형태여서 안된다.



// 구조체(value 타입)
struct Sample {
    var mutableProperty: Int = 100
    let immutableProperty: Int = 100 // 인스턴스 프로퍼티
    
    static var typeProperty: Int = 100 // 구조체 타입 프로퍼티
    
    func instanceMethod() {
        print("Hello instance Method")
    }
    
    static func typeMethod() {
        print("Hello type Method")
    }
}

var mutable: Sample = Sample()
mutable.mutableProperty = 1230
mutable.instanceMethod()
Sample.typeProperty = 2222
print(mutable)

// 클래스(reference 타입) 다중상속 지원x

class Student {
    var age: Int = 0
    var name: String = "hamin"
    var `class`: String = "Swift"
    
    // 인스턴스 메소드
    func instanceMethod() {
        print("instance method")
    }
    
    // 타입 메서드
    // 상속시 재정의 불가 타입 메서드 - static
    static func typeMethod() {
        print("type method - static")
    }
    
    // 상속시 재정의 가능 타입 메서드 - class
    class func classMethod() {
        print("type method - class")
    }
}


// ## 특징 클래스의 인스턴스를 let으로 선언해도 내부 프로퍼티가 var형태라면 수정가능

let jina: Student = Student()
jina.age = 23
print(jina.age)



// 열거형 enum

//C 언어의 enum 처럼 정수값을 가질 수 있습니다.
//rawValue는 case별로 각각 다른 값을 가져야합니다.
//자동으로 1이 증가된 값이 할당됩니다.
//rawValue를 반드시 지닐 필요가 없다면 굳이 만들지 않아도 됩니다.

enum Weekday {
    case mon
    case tue
    case wed
    case thu, fri, sat, sun
}

var day: Weekday? = nil
//day = .tue

if let temp = day {
    print(temp)
} else {
    print("nil")
}

enum Fruit: Int {
    case apple = 0
    case banana = 3
    case peach
}
print(Fruit.peach.rawValue)
// 원시값 형태로 반환시 값이 없으면 자동으로 이전변수 +1

enum School: String {
    case elementary = "초등"
    case middle = "중등"
    case high = "고등"
    case univer
    
    func printSchool() {
        switch self {
        case .elementary:
            print("elementary")
        default:
            print("DEFAULT")
        }
    }
}
// 원시값 형태로 반환시 값이 없는 변수는 case의 이름을 가지고 온다.
School.elementary.printSchool()
School.middle.printSchool()
