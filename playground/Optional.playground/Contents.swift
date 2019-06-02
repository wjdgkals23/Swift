// Optional
// 옵셔널은 예외상황을 최소화하는 안전한 코딩을 가능하게 해주는 요소
// 옵셔널형태가 아닌 변수들은 무조건 값을 가지고 있어야한다는 뜻을 내포한다.
// ! 암시적 추출 옵셔널
var optional:Int! = 0
let temp = optional + 1 // 기존 변수처럼 사용가능
optional = nil // nil 할당가능
//let temp2 = optional + 1
// ? 옵셔널 타입 : nil 과 옵셔널 타입으로 일반변수처럼 사용 불가 추출해야한다!!

// 옵셔널 추출
var optional2:Int? = 3
// if let 방식
if let temp = optional2 {
    print(temp + 1)
} else {
    print("error")
}

let ttemp:Int = optional2 != nil ? optional2! : 0
print(ttemp)

// optional 추출방식중 옵셔널 체이닝을 이용하게 되면 성공시 무조건 옵셜널타입의 결과값을 얻게 된다.
//가장 큰 차이는 강제 언레핑을 했는데 만약 그 값이 없으면 런타임 에러가 발생하지만, 옵셔널 체이닝을 사용하면 런타임 에러 대신 nil이 반환 된다는 것입니다.
class Person {
    var residence: Residence?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int { // only get
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}
let john = Person()
john.residence = Residence()
//print(john.residence?.numberOfRooms + 2) error

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
