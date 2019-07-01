//
//  CardDeck.swift
//  PlayingCard
//
//  Created by 정하민 on 25/06/2019.
//  Copyright © 2019 HMJeong. All rights reserved.
//

import Foundation

struct CardDeck: CustomStringConvertible { // 카드덱 구현
    var description: String { return "" }
    private(set) var cards: [Card] = [Card]();
    
    init() { // 카드의 숫자와 문양 갯수만큼 카드덱을 초기화한다.
        for suit in Card.Suit.all {
            for rank in Card.Rank.all {
                cards.append(Card.init(suit: suit, rank: rank))
            }
        }
    }
    
    mutating func draw() -> Card? { // 랜덤 정수를 이용하여 card 덱에서 랜덤카드를 꺼낸다.
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}

extension Int { // 랜덤 정수를 설정하기 위한 확장
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
