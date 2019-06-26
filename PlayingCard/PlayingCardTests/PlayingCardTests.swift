//
//  PlayingCardTests.swift
//  PlayingCardTests
//
//  Created by 정하민 on 25/06/2019.
//  Copyright © 2019 HMJeong. All rights reserved.
//

import XCTest
@testable import PlayingCard

class PlayingCardTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let cards = Card.init(suit: .clubs, rank: .face("J"))
        XCTAssertTrue(cards.description == "")
    }
    
    func testCardDeckCountCorrect() {
        var cardDeck = CardDeck.init()
        let removedCard = cardDeck.draw()
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
