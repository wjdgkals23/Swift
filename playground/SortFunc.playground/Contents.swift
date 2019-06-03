//
//  main.swift
//  SortFuncPractice
//
//  Created by 정하민 on 03/06/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import Foundation

func selectionSort(_ arr:[Int]) -> [Int] {
    guard arr.count > 1 else { return arr }
    
    var a = arr
    
    for x in 0..<a.count-1 {
        var lowest = x
        for y in x+1..<a.count {
            if a[y] < a[lowest] {
                lowest = y
            }
        }
        if x != lowest {
            a.swapAt(x, lowest)
        }
    }
    return a
}

let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
print(selectionSort(list))


func insertionSort(_ arr:[Int]) -> [Int] {
    var a = arr
    
    for x in 1..<a.count {
        var y = x
        let temp = a[x]
        while y > 0 && temp < a[y-1] {
            a[y] = a[y-1]
            y-=1
        }
        a[y] = temp
    }
    return a
}

print(insertionSort(list))

func mergeSort(_ arr:[Int]) -> [Int] {
    guard arr.count > 1 else { return arr }
    let mid = arr.count/2
    
    let left = mergeSort(Array(arr[0..<mid]))
    let right = mergeSort(Array(arr[mid..<arr.count]))
    return merge(left,right)
}

func merge(_ left:[Int], _ right:[Int]) -> [Int] {
    var leftInd = 0
    var rightInd = 0
    
    var orderedPile = [Int]()
    orderedPile.reserveCapacity(left.count + right.count)
    
    while leftInd<left.count && rightInd<right.count  {
        if(left[leftInd] < right[rightInd]) {
            orderedPile.append(left[leftInd])
            leftInd+=1
        } else if (left[leftInd] > right[rightInd]) {
            orderedPile.append(right[rightInd])
            rightInd+=1
        } else {
            orderedPile.append(left[leftInd])
            leftInd+=1
            orderedPile.append(right[rightInd])
            rightInd+=1
        }
    }
    
    while leftInd<left.count {
        orderedPile.append(left[leftInd])
        leftInd+=1
    }
    while rightInd<right.count {
        orderedPile.append(right[rightInd])
        rightInd+=1
    }
    return orderedPile
}

print(mergeSort(list))

func quickSort(_ arr:[Int]) -> [Int] {
    guard arr.count > 1 else { return arr }
    
    let pivot = arr[arr.count/2]
    let left = quickSort(arr.filter{ $0 < pivot })
    let equal = arr.filter{ $0 == pivot } // 같은 값은 빼주어야한다.
    let right = quickSort(arr.filter{ $0 > pivot })
    
    return left + equal + right
}

print(quickSort(list))
