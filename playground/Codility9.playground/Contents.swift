import Foundation


// 정수 A 배열에서 0<=P<=Q<=N 일 경우 A[Q]-A[P] 가 가장 큰 값을 반환해라
public func solution9_1(_ A : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    if(A.count == 0 || A.count == 1) {
        return 0
    }
    var temp = A[0]
    var result = 0
    for i in 1...A.count-1 {
        temp = min(temp,A[i-1])
        result = max(result,A[i]-temp)
    }
    return result
}

// 정수 A 배열에서 0<=P<=Q<=N 일 경우 P-Q 사이 합이 가장 큰 값을 반환해라
public func solution9_2(_ A : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    if (A.count == 1) {
        return A[0]
    }
    var ending = A[0]
    var slicing = A[0]
    for i in 1...A.count-1 {
        ending = max(A[i], ending + A[i])
        slicing = max(slicing, ending)
    }
    
    return slicing
}
var a = [1]
print(solution9_2(&a))

public func solution9_3(_ A : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    for i in A.indices {
        
    }
}
