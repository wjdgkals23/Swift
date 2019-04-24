//
//  TableViewController.swift
//  SimpleTable
//
//  Created by 정하민 on 20/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let food: [String] = ["김치", "미역국", "된장", "김치", "미역국", "된장", "김치", "미역국", "된장", "김치", "미역국", "된장", "김치", "미역국", "된장", "김치", "미역국", "된장"]
    let music: [String] = ["가을안부", "소주한잔", "가을안부", "소주한잔", "가을안부", "소주한잔", "가을안부", "소주한잔", "가을안부", "소주한잔"]
    var date: [Date] = []
    
    var dateFormatter: DateFormatter = {
        var temp = DateFormatter()
        temp.dateStyle = .medium

        return temp
    }()
    
    var timeFormatter: DateFormatter = {
        var temp = DateFormatter()
        temp.timeStyle = .short
        
        return temp
    }()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
        case 2:
            return date.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section > 1 {
            let cell: CutomTableViewCell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! CutomTableViewCell
            cell.rightLabel.text = timeFormatter.string(from: date[indexPath.row])
            cell.leftLabel.text = dateFormatter.string(from: date[indexPath.row])
            return cell
        } else {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = indexPath.section == 0 ? food[indexPath.row] : music[indexPath.row]
            if(indexPath.row == 2) {
                cell.backgroundColor = UIColor.red
            } else {
                cell.backgroundColor = UIColor.white
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return nil
        }
        return section == 0 ? "음식" : "노래"
    }
    
    @IBAction func addDateData(_ sender: Any) {
        date.append(Date())
        
        self.tableView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedCellView = segue.destination as? SelectedCellViewController else {
            return
        }
        
        guard let senderCell = sender as? UITableViewCell else {
            return
        }
        
        if let tempString: String = senderCell.textLabel?.text {
            selectedCellView.setText = tempString
        } else {
            selectedCellView.setText = "실패"
        }
        
    }

}
