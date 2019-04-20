//
//  TableViewController.swift
//  SimpleTable
//
//  Created by 정하민 on 20/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let food: [String] = ["김치", "미역국", "된장"]
    
    let music: [String] = ["가을안부", "소주한잔"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return food.count
        case 1:
            return music.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = indexPath.section == 0 ? food[indexPath.row] : music[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSsection section: Int) -> String? {
        return section == 0 ? "음식" : "노래"
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
