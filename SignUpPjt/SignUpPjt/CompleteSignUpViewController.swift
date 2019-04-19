//
//  CompleteSignUpViewController.swift
//  SignUpPjt
//
//  Created by 정하민 on 19/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class CompleteSignUpViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var registerDatePicker: UIDatePicker!
    
    var dateString: String = ""
    let dateFormatter: DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("load")
        
        registerDatePicker.addTarget(self, action: #selector(dateValueChange), for: UIControl.Event.valueChanged)
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM/DD/YYYY")
        // Do any additional setup after loading the view.
        dateString = dateFormatter.string(from: registerDatePicker!.date)
        dateLabel.text = dateString
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dateValueChange(datePicker: UIDatePicker) {
        dateString = dateFormatter.string(from: registerDatePicker!.date)
        dateLabel.text = dateString
    }
}
