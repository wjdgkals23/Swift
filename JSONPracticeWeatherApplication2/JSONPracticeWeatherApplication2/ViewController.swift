//
//  ViewController.swift
//  JSONPracticeWeatherApplication2
//
//  Created by 정하민 on 30/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var nationData: [Nation] = [Nation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        
        guard let asset = NSDataAsset(name: "countries") else {
            fatalError("Missing data asset: countries")
        }
        
        let data = asset.data
//        print(data)
        let decoder = JSONDecoder()
        nationData = try! decoder.decode(Array<Nation>.self, from: data)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(section)
        return nationData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nationcell") as! NationTableViewCell
        let text = "flag_" + nationData[indexPath.row].asset_name
        cell.cellImageView.image = UIImage(named: text)
        cell.cellLabel.text = nationData[indexPath.row].asset_name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var tempText: String
        if sender is NationTableViewCell {
            let tempCell :NationTableViewCell = sender as! NationTableViewCell
            tempText = tempCell.cellLabel.text!
        } else {
            return
        }
        
        if segue.destination is NationWeatherViewController {
            let tempViewCon = segue.destination as! NationWeatherViewController
            tempViewCon.nation = tempText
        } else {
            return
        }
    }

}

