import UIKit

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
} // 전역함수 : 이름이 있고 어떤 값도 캡쳐하지 않는 클로저

names.sorted(by: backward) // 절대 names를 바꾸는 것 ㄴㄴ!
var sortedNames = names.sorted(by: { (s1:String, s2:String) -> Bool in
    return s1 > s2
})
var sortedNames2 = names.sorted() { return $0 > $1 }
sortedNames
sortedNames2

// 후위 클로저 + 고차 함수

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var number = number
    print(number)
    var output = ""
    
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    
    return output
}

print(strings)

let sortednumber = numbers.sorted { (first: Int, second: Int) -> Bool in
    return first > second
}

print(sortednumber)

// 중첩 함수 _ 값 캡쳐
func makeIncrementer(forIncrement amount: Int) -> () -> Int { // Int 인자를 받고 () -> Int 형태의 함수를 반환한다.
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
incrementByTen()
incrementByTen()
incrementByTen()

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
incrementBySeven()
incrementBySeven()


// 이스케이핑 클로저 : 큐를 이용한 비동기 연산의 완료 핸들러, 밖에서 처리될 함수는 필수!!
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()    // 함수 안에서 끝나는 클로저
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { [weak self] in self?.x = 100 } // 외부에서 처리될 함수에 대해 weak self를 처리하는 이유는 어떠한 이유던지 해당 Class를 크래시로 부터 보존하기 위함이다.
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

let customerProvider: ()->String = { customersInLine.remove(at: 0) }// 자동클로저는 인자 값이 없으며 톡정 표현을 감싸서 다른 함수에 전달 인자로 사용할 수 있는 클로저
print(customersInLine.count)
// Prints "5"

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"

// autoclosure를 이용하여
// 함수의 인자 값을 넣을 때 클로저가 아니라 클로저가 반환하는 반환 값과 일치하는 형의 함수를 인자로 넣을 수 있습니다.
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}

serve(customer: customersInLine.remove(at: 0) )
