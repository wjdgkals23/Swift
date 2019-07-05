import Foundation

public func solution8_1(_ A : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    if (A.count == 0) {
        return -1
    }
    if (A.count == 1) {
        return 0
    }
    
    var leader = 0;
    var stack: [Int] = [Int]()
    stack.append(A[0])
    for i in 1...A.count-1 {
        if(stack.isEmpty) {
            stack.append(A[i])
            continue
        }
        let temp = stack.removeLast()
        if(temp == A[i]) {
            stack.append(A[i])
        }
    }
    
    if stack.count == 0 {
        return -1
    }
    
    leader = stack.removeLast()
    
    for i in A.indices {
        if (leader == A[i]) {
            return i
        }
    }
    
    return -1
}
// 66퍼 leader 상수가 없는 경우 가장 마직막에 있는 요소가 가짜 leader로 임명된다.


public func solution8_1_1(_ A : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    if (A.count == 0) {
        return -1
    }
    if (A.count == 1) {
        return 0
    }
    
    var value = 0
    var size = 0
    
    for i in A.indices {
        if (size == 0) {
            size+=1
            value = A[i]
        } else {
            if(value != A[i]) {
                size-=1
            } else {
                size+=1
            }
        }
    }
    
    var count = 0
    var pos = 0
    for i in A.indices {
        if(value == A[i]) {
            count+=1
            pos = i
        }
    }
    
    var half = 0
    
    half = (A.count + 1)/2
    if(A.count%2 == 0) {
        half = A.count/2
    }
    
    if(count > half) {
        return pos
    }
    
    return -1
}
