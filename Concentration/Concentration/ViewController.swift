//
//  ViewController.swift
//  Concentration
//
//  Created by 정하민 on 11/06/2019.
//  Copyright © 2019 JHM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var flipCnt: Int = 0
    let puzzleEmoj: [String] = ["👻","🎃","👻","🎃"]
    @IBOutlet var puzzleButtons: [UIButton]!
    @IBOutlet weak var flipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func filpAction(_ sender: UIButton) {
        
        let puzzleNum = puzzleButtons.firstIndex(of: sender)
        if let realNum = puzzleNum {
            flipCnt = flipCnt + 1
            flipLabel.text = "Flip : \(flipCnt)"
            filpFunc(at: sender, on: puzzleEmoj[realNum])
        } else {
            print("not found sender")
        }
    }
    
    func filpFunc(at button: UIButton, on text: String) {
        print(button)
        print(text)
        if button.currentTitle != text {
            button.setTitle(text, for: UIControl.State.normal)
            button.backgroundColor = UIColor.black
        } else {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = UIColor.red
        }
    }
    
}

