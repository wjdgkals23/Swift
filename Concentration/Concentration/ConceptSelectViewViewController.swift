//
//  ConceptSelectViewViewController.swift
//  Concentration
//
//  Created by 정하민 on 03/07/2019.
//  Copyright © 2019 JHM. All rights reserved.
//

import UIKit

class ConceptSelectViewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
        "Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectConcept" {
            if let theme = (sender as? UIButton)?.currentTitle, let concept = themes[theme]  {
                if let concentrationView = segue.destination as? ConcentrationViewController {
                    concentrationView.theme = concept
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
