//
//  ViewController2.swift
//  Concentration
//
//  Created by 정하민 on 17/06/2019.
//  Copyright © 2019 JHM. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let buttons: CardButtonDumps = CardButtonDumps.init(4, 5, self.view.frame.size.width)
        for i in 0...buttons.buttonArr.count-1 {
            self.view.addSubview(buttons.buttonArr[i])
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
