import Foundation

public func solution(_ A : inout [Int]) -> Int {
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
