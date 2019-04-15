//
//  SecondSecondViewController.swift
//  NavigationPractice
//
//  Created by 정하민 on 11/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var popButton: UIButton!
    @IBOutlet var presentationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
<<<<<<< Updated upstream
        nameLabel.text = UserInfo.shared.name
        ageLabel.text = UserInfo.shared.age
=======
        print("SecondViewController Did Load")
>>>>>>> Stashed changes
    }
    
    @IBAction func popToView() {
    self.navigationController?.popViewController(animated: true);
    }
    
    @IBAction func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("SecondViewController Will Appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("SecondViewController Will Disappear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("SecondViewController Did Appear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("SecondViewController Did Disappear")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("SecondViewController Subview Did Appear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("SecondViewController Subview Will Appear")
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
