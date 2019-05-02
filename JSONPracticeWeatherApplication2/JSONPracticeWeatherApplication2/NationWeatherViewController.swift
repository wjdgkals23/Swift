//
//  NationWeatherViewController.swift
//  JSONPracticeWeatherApplication2
//
//  Created by 정하민 on 02/05/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class NationWeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var nation: String = ""
    var weatherJson: [Weather] = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = false
        
        guard let nationWeatherAsset = NSDataAsset(name: nation) else {
            fatalError("Missing data asset: nation countries json")
        }
        
        let data = nationWeatherAsset.data
        
        let decoder = JSONDecoder()
        if let tempJson = try? decoder.decode(Array<Weather>.self, from: data) {
            print("JSON decoded")
            weatherJson = tempJson
        } else {
            print("JSON decode failed")
        }
        
        print(weatherJson)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherJson.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: "weathercell") as! WeatherTableViewCell
        cell.cityName.text = weatherJson[indexPath.row].city_name
        cell.rainProb.text = String(weatherJson[indexPath.row].rainfall_probability)
        cell.cityTemper.text = String(weatherJson[indexPath.row].celsius)
        
        switch weatherJson[indexPath.row].state {
        case 10:
            cell.imageView?.image = UIImage(named: "sunny")
        case 11:
            cell.imageView?.image = UIImage(named: "cloudy")
        case 12:
            cell.imageView?.image = UIImage(named: "rainy")
        case 13:
            cell.imageView?.image = UIImage(named: "snowy")
        default:
            print("not provide type")
        }
        
        return cell
    }
            
}
