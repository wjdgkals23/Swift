import UIKit

var str = "Hello, playground"

// 타입 캐스팅

class Person {
    var name: String = ""
    
    func breathe() -> Void {
        print("숨쉰다")
    }
}

class Student: Person {
    var school: String = ""
    
    func goToSchool() -> Void {
        print("등교시간")
    }
}

class UniversityStudent: Student {
    var major: String = ""
    
    func goToMT() -> Void {
        print("멤버십 트레이닝")
    }
}

var yagom: Person = UniversityStudent() as Person
yagom.name = "yagom"
//yagom is Person true
//yagom is UniversityStudent true
//yagom is Student true
yagom as? Student
yagom as? UniversityStudent

var hana: Student = Student()
hana is UniversityStudent
var jason: UniversityStudent = UniversityStudent()

// 업 캐스팅
var mike: Person = UniversityStudent() // as Person 생략 가능
type(of: mike)

// 다운 캐스팅
// 실질적으로 할당된 객체 형태가 무엇인지
var optional = yagom as? UniversityStudent


//assert guard 검증을 위한 아이들
var someInt: Int = 0

// 검증 조건과 실패시 나타날 문구를 작성해 줍니다
// 검증 조건에 부합하므로 지나갑니다
//assert(someInt == 1, "someInt != 0")

someInt = 1
//assert(someInt == 0) // 동작 중지, 검증 실패
//assert(someInt == 0, "someInt != 0") // 동작 중지, 검증 실패
//assertion failed: someInt != 0: file guard_assert.swift, line 26

func validate(num: Int?) -> Void {
    guard let temp = num,
        temp < 130,
        temp > 0 else {
            print("쓰레기 값")
            return
    }
    print("검증된 숫자는 \(temp)")
}

validate(num: 14)

// 기능확장
extension Int {
    var isEven: Bool {
        return self%2 == 0
    }
    var isOdd: Bool {
        return self%2 == 1
    }
    
    mutating func square() -> Int
    {
        self = self*self
        return self
    }
}

var a: Int = 4
a.isOdd
print(a.square())
a


// Error 처리
// 재고부족, 잔액부족, 부적절한 금액
enum VendingMachineError: Error {
    case invalidInput
    case insufficientFunds(moneyNeed: Int)
    case outOfStock
}

class VendingMachine {
    let itemPrice: Int = 100
    var itemCount: Int = 5
    var deposited: Int = 0
    
    func receiveMoney(_ money: Int) throws {
        guard money > 0 else {
            throw VendingMachineError.invalidInput
        }
        
        self.deposited += money
        print("\(money)를 받았습니다")
    }
    
    func vend(numberOfItems numberOfItemsToVend: Int) throws -> String {
        guard numberOfItemsToVend > 0 else {
            throw VendingMachineError.invalidInput
        }
        
        guard numberOfItemsToVend * itemPrice <= deposited else {
            throw VendingMachineError.insufficientFunds(moneyNeed: numberOfItemsToVend * itemPrice - deposited)
        }
        
        guard itemCount >= numberOfItemsToVend else {
            throw VendingMachineError.outOfStock
        }
        
        let totalPrice = numberOfItemsToVend * itemPrice
        
        self.deposited -= totalPrice
        self.itemCount -= numberOfItemsToVend
        
        return "\(numberOfItemsToVend)개 제공함"
    }
}

let machine: VendingMachine = VendingMachine()

var result: String?

do {
    try machine.receiveMoney(1000)
} catch let error {
    switch error {
    case VendingMachineError.invalidInput:
        print("돈이 왜케 적어요 ㅡㅡ")
    case VendingMachineError.insufficientFunds(let moneyNeed):
        print("돈 \(moneyNeed)만큼 더 넣어요ㅡㅡ")
    case VendingMachineError.outOfStock:
        print("재고 없지롱 메롱ㅋ")
    default:
        print("현재 처리가 불가한 상태입니다")
    }
}

do {
    result = try machine.vend(numberOfItems: 3)
} catch let error {
    print(error)
}

result = try? machine.vend(numberOfItems: 2)

result = try? machine.vend(numberOfItems: 2)

if let last_result = result {
    print("거래 정상 종료")
} else {
    print("nil")
}

