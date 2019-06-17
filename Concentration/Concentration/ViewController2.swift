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

//        let cardLine:CardLine = CardLine.init(1, 4, 30, 40, CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let rect = CGRect.init(x: 0, y: 0, width: 30, height: 40)
        let card = CardLine.init(6, 1, self.view.frame.size.width, self.view.frame.size.height, rect)

        self.view.addSubview(card)
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
