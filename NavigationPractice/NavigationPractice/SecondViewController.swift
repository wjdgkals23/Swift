//
//  SecondViewController.swift
//  NavigationPractice
//
//  Created by 정하민 on 11/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var popButton: UIButton!
    @IBOutlet var presentationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func popToView() {
    self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func dismissView() {
        self.dismiss(animated: true, completion: nil)
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
