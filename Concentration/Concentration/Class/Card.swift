//
//  Card.swift
//  Concentration
//
//  Created by 정하민 on 12/06/2019.
//  Copyright © 2019 JHM. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var hashValue: Int { return identifier }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(hashValue)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    // struct 의 특징은 값 타입이라는 것, 복사형태로 값이 전달된다는 것, 기본 init(모든 프로퍼티를 초기화)를 기본 제공한다는 것
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

// 카드 객체의 특징
// 고유한 번호를 가진 2쌍의 페어가 있어야한다.
// 카드가 뒤집어졌는지 알 수 있어야한다.
// 카드가 맞춰진 상태인지 확인해야한다.
