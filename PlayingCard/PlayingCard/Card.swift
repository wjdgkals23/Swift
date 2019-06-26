//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by 정하민 on 25/06/2019.
//  Copyright © 2019 HMJeong. All rights reserved.
//

import Foundation

struct Card: CustomStringConvertible {
    var description: String { return " " }
    
    var suit:Suit
    var rank:Rank
    
    enum Suit: String {
        case spades = "♠️"
        case hearts = "❤️"
        case dimonds = "♣️"
        case clubs = "♦️"
        
        static var all = [Suit.spades, .hearts, .dimonds, .clubs];
    }
    
    enum Rank {
        case ace
        case face(String)
        case numeric(Int)
        
        var order: Int{
            switch self {
            case .ace: return 1
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            case .numeric(let pips): return pips
            default: return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2...10{
                allRanks.append(Rank.numeric(pips))
            }
            allRanks += [Rank.face("J"),Rank.face("Q"),Rank.face("K")]
            return allRanks
        }
    }
}
