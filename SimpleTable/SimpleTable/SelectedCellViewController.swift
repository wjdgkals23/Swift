//
//  SelectedCellViewController.swift
//  SimpleTable
//
//  Created by 정하민 on 24/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class SelectedCellViewController: UIViewController {
    
    var setText: String = ""

    @IBOutlet weak var tempText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        tempText.text = setText
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
