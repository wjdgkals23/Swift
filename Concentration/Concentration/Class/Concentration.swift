//
//  Concentration.swift
//  Concentration
//
//  Created by 정하민 on 12/06/2019.
//  Copyright © 2019 JHM. All rights reserved.
//

import Foundation

struct Concentration{
    
    private(set) var cards: [Card] = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? { // 어떤 상태를 통해 파생되는 변수이므로 computed 형태로 생성하여 무결성을 지켜주는 것이 좋다.
        get {
            var foundIndex: Int? // nil로 초기화
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = ( index == newValue )
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        // 오류에 대한 확률이 있는 함수에 대해 assert를 통해 디버그를 할 곳을 지시할 수 있다.
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(numberOfPairsCards: \(numberOfPairsOfCards))")
        for _ in 1...numberOfPairsOfCards {
            let card: Card = Card.init()
            cards += [card,card]
        }
        // TODO: shuffle
        for _ in 1...cards.count {
            cards.swapAt(Int(arc4random_uniform(UInt32(cards.count))), Int(arc4random_uniform(UInt32(cards.count))))
        }
    }
    
}
