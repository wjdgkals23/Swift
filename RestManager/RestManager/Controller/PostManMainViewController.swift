//
//  PostManMainViewController.swift
//  RestManager
//
//  Created by 정하민 on 12/07/2019.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import UIKit

class PostManMainViewController: UIViewController {

    @IBOutlet weak var methodSwitch: UISwitch!
    @IBOutlet weak var baseURL: UITextField!
    @IBOutlet weak var resultBinding: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    lazy var restManager: RestManager = RestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func requestAction(_ sender: Any) {
        print("temp")
        var httpMethod: RestManager.HttpMethod = .get
        if(methodSwitch.isOn) {
            httpMethod = .post
        }
        
        if let exportURL = baseURL.text {
            if let realURL = URL.init(string: exportURL) {
                restManager.makeRequest(toURL: realURL, withHttpMethod: httpMethod) { (results) in
                    print("success")
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
