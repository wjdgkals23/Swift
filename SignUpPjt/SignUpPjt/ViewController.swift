//
//  ViewController.swift
//  SignUpPjt
//
//  Created by 정하민 on 16/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view .endEditing(true)
    }


}

