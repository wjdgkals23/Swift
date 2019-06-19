//
//  Card.swift
//  Concentration
//
//  Created by 정하민 on 12/06/2019.
//  Copyright © 2019 JHM. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var isFaceUp = false
    var isMatched = false
    //    [C2-4]
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

// 카드 객체의 특징
// 고유한 번호를 가진 2쌍의 페어가 있어야한다.
// 카드가 뒤집어졌는지 알 수 있어야한다.
// 카드가 맞춰진 상태인지 확인해야한다.
