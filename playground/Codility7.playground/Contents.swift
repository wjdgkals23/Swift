import Foundation

// 물고기는 크기와 방향을 가지고 있다. 물고기의 인덱스가 작을수록 상류에 있는 물고기이다. 상류에서 내려오는 물고기와 하류에서 올라가는 물고기가 만났을때 더 큰 물고기만 살아남는다. 총 물고기가 몇마리 살아남는가
public func solution(_ A : inout [Int], _ B : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    var z_stack: [Int] = [Int]()
    var o_stack: [Int] = [Int]()
    
    if A.count == 1 || A.count == 0 {
        return A.count
    }
    
    for i in A.indices {
        if(B[i] == 1) {
            o_stack.append(i)
        } else {
            if o_stack.isEmpty {
                z_stack.append(i)
            } else {
                while !o_stack.isEmpty {
                    let temp = o_stack.removeLast()
                    if A[temp] > A[i] {
                        o_stack.append(temp)
                        break
                    }
                }
                if o_stack.isEmpty {
                    z_stack.append(i)
                }
            }
        }
    }
    
    return z_stack.count + o_stack.count
}

var A = [4, 3, 2, 1, 5]
var B = [0, 1, 0, 0, 0]

print(solution(&A, &B))
