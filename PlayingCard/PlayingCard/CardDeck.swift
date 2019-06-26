//
//  CardDeck.swift
//  PlayingCard
//
//  Created by 정하민 on 25/06/2019.
//  Copyright © 2019 HMJeong. All rights reserved.
//

import Foundation

struct CardDeck: CustomStringConvertible {
    var description: String { return "" }
    private(set) var cards: [Card] = [Card]();
    
    init() {
        for suit in Card.Suit.all {
            for rank in Card.Rank.all {
                cards.append(Card.init(suit: suit, rank: rank))
            }
        }
    }
    
    mutating func draw() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}

extension Int {
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
