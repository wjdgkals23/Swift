//
//  ViewController.swift
//  TargetAction
//
//  Created by 정하민 on 15/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var myDatePicker: UIDatePicker!
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myTextField: UITextField!
    
    let formatter: DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.myDatePicker.addTarget(self, action: #selector(chLabel(_:)), for: UIControl.Event.valueChanged)
        
        let tapRecognizer: UIGestureRecognizer = UITapGestureRecognizer()
        tapRecognizer.delegate = self
        
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @IBAction func chLabel(_ sender: UIDatePicker) {
        print(sender.date)
        self.formatter.dateStyle = .medium
        myLabel.text = self.formatter.string(from: sender.date)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("tap")
        self.view.endEditing(true)
        return true
    }

}

