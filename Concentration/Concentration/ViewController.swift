//
//  ViewController.swift
//  Concentration
//
//  Created by 정하민 on 11/06/2019.
//  Copyright © 2019 JHM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: cardButtons.count/2) // 초기화 부분에서는 init이 일어난 이후 self에 해당하는 요소들에 접근할 수 있다. lazy를 활용하면 self 요소들에 접근할 수 있다.
    
    var flipCount: Int = 0 {
        didSet {
            let attributes: [NSAttributedString.Key:Any] = [
                .strokeWidth: 5.0,
                .strokeColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            ]
            let attributedString = NSAttributedString.init(string: "Flip : \(flipCount)", attributes: attributes)
            flipCountLabel.attributedText = attributedString
        }
    }
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount = flipCount + 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("not found sender")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
//    var emojiChoices: [String] = ["👻","🐯","🐻","🦀","🎲"]
    private var emojiChoices: String = "👻🐯🐻🦀🎲"
    var emoji: Dictionary<Int,String> = Dictionary<Int,String>()
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card.identifier] = String(emojiChoices.remove(at: randomStringIndex))
        }
        let chosenEmoji = emoji[card.identifier]
        return chosenEmoji ?? "?"
    }
}

extension Int {
    var arc4random: Int{
        if self>0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

