//
//  ViewController.swift
//  JsonPracticeWeatherApplication
//
//  Created by 정하민 on 29/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    var images = ["flag_de","flag_fr","flag_it","flag_jp","flag_kr","flag_us"]
    var nationData: [Nation] = [Nation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "nationcell")
        
        guard let asset = NSDataAsset(name: "countries") else {
            fatalError("Missing data asset: countries")
        }
        
        let data = asset.data
        print(data)
        let decoder = JSONDecoder()
        nationData = try! decoder.decode(Array<Nation>.self, from: data)
        print(nationData)

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "nationcell") as! TableViewCell;
//        print(nationData[indexPath.row].asset_name)
        let text = "flag_" + nationData[indexPath.row].asset_name
        let image = UIImage(named: text)
        cell.cellImageView.image = image
        cell.imageLabel.text = nationData[indexPath.row].korean_name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedCellView = segue.destination as? WeatherTableViewController else {
            return
        }
        
        guard let senderCell = sender as? TableViewCell else {
            return
        }
        
        if let tempString: String = senderCell.imageLabel.text {
            selectedCellView.setText = tempString
        } else {
            selectedCellView.setText = "실패"
        }
    }
    
    func segueAction() {
        self.show(WeatherTableViewController.init(), sender: <#T##Any?#>)
    }
}

extension UIImage  {
    func getCropRatio() -> CGFloat {
        let widthRatio: CGFloat = CGFloat(self.size.width/self.size.height)
        return widthRatio
    }
}

