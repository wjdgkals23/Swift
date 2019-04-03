import UIKit

var str = "Hello, playground"

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count

for name in names[2...] {
    print(name)
}

var emptyString = String()
if emptyString.isEmpty {
    print("is empty")
} else {
    print("not empty")
}

var someInts = [Int]()
someInts.append(3)
someInts.append(4)
print(someInts)

var someInts2 = Array(repeating: 3, count: 5)
print(someInts2)

var totalsomeInts = someInts2 + someInts


var strArr:[String] = ["TEMP","TEMP2"];
strArr.append("E")
strArr.insert("EE", at: 2)



//function solution(A) {
//    // write your code in JavaScript (Node.js 8.9.4)
//    let temp_ans = 0;
//    let ans = 0;
//    let max = 1000000000;
//
//    for(let i=0; i<A.length; i++){
//        if(A[i] === 0) {
//            temp_ans++;
//        }
//        else {
//            ans+=temp_ans;
//            if(ans>max)
//            return -1;
//        }
//    }
//
//    return ans>max ? -1:ans;
//}

public func solution(_ A: inout [Int]) -> Int {
    var temp_ans = 0
    var ans = 0
    let max = 1000000000
    
    for item in A {
        if item == 0 {
            temp_ans+=1
        } else {
            ans+=temp_ans
            if ans > max {
                return -1
            }
        }
    }
    
    //ternary operator
    return ans>max ? -1:ans
}

var arr:[Int] = [0,0,1,1,0,1,1]
print(solution(&arr))

// return optional, tuple value
func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        }
        if value > currentMax {
            currentMax = value
        }
    }
    return (min: currentMin, max: currentMax)
}

if let temp = minMax(array: [8,-6,2,109,3,71]) {
    print("min is \(temp.min) max is \(temp.max)")
} else {
    print("is nil")
}

// inout call by reference
func swap(_ a: inout Int, _ b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}

var a = 2
var b = 3
swap(&a, &b)
print(a,b)
