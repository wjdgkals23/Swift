//
//  ViewController.swift
//  PlayingCard
//
//  Created by 정하민 on 25/06/2019.
//  Copyright © 2019 HMJeong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var deck = CardDeck()
    
    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(playingCardView.adjustFaceCardScale))
            playingCardView.addGestureRecognizer(pinch)
        }
    }
    
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch (sender.state) {
        case .ended:
            playingCardView.isFaceUp = !playingCardView.isFaceUp
        @unknown default:
            print("not")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func nextCard() {
        if playingCardView.isFaceUp {
            if let card = deck.draw() {
                playingCardView.rank = card.rank.order
                playingCardView.suit = card.suit.rawValue
            }
        } else {
            return
        }
    }
    
}

