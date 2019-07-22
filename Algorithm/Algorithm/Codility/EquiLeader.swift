//
//  EquiLeader.swift
//  Algorithm
//
//  Created by 정하민 on 14/07/2019.
//  Copyright © 2019 JHM. All rights reserved.
//

//A non-empty array A consisting of N integers is given.
//
//The leader of this array is the value that occurs in more than half of the elements of A.
//
//An equi leader is an index S such that 0 ≤ S < N − 1 and two sequences A[0], A[1], ..., A[S] and A[S + 1], A[S + 2], ..., A[N − 1] have leaders of the same value.
//
//For example, given array A such that:
//
//A[0] = 4
//A[1] = 3
//A[2] = 4
//A[3] = 4
//A[4] = 4
//A[5] = 2
//we can find two equi leaders:
//
//0, because sequences: (4) and (3, 4, 4, 4, 2) have the same leader, whose value is 4.
//2, because sequences: (4, 3, 4) and (4, 4, 2) have the same leader, whose value is 4.
//The goal is to count the number of equi leaders.
//
//Write a function:
//
//public func solution(_ A : inout [Int]) -> Int
//
//that, given a non-empty array A consisting of N integers, returns the number of equi leaders.
//
//For example, given:
//
//A[0] = 4
//A[1] = 3
//A[2] = 4
//A[3] = 4
//A[4] = 4
//A[5] = 2
//the function should return 2, as explained above.
//
//Write an efficient algorithm for the following assumptions:
//
//N is an integer within the range [1..100,000];
//each element of array A is an integer within the range [−1,000,000,000..1,000,000,000].

import Foundation

public func isLeader(_ a:Int, _ b:Int) -> Bool {
    if(b%2 == 0) {
        let half = b/2
        return a > half ? true : false
    }
    return a >= ((b + 1)/2) ? true : false
}

public func solution8_2(_ A : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    var ans: Int = 0
    var size: Int = 0
    var value: Int = 0
    
    for i in A.indices {
        if(size == 0) {
            value = A[i]
            size += 1
        } else {
            if(A[i] == value) {
                size += 1
            } else {
                size -= 1
            }
        }
    }
    
    var count: Int = 0
    
    for i in A.indices {
        if(value == A[i]) {
            count += 1
        }
    }
    
    if(!isLeader(count, A.count)) {
        return 0
    }
    
    var temp: Int = 0
    
    for i in A.indices {
        if(value == A[i]) {
            temp += 1
            count -= 1
        }
        if(isLeader(temp, i+1) && isLeader(count, A.count-i-1)) {
            ans += 1
        }
    }
    
    return ans
}

// Leader(자신의 범위내에서 절반초과하게 해당 숫자가 분포된 경우 Leader이다) 를 찾고 각 분기마다 리더가 동일하면 ans ++ 하는 방식
