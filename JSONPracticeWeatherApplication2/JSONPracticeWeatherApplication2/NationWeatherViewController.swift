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
        for item in cell.uiView.subviews {
            item.removeFromSuperview()
        }
        cell.cityName.text = weatherJson[indexPath.row].city_name
        cell.rainProb.text = String(weatherJson[indexPath.row].rainfall_probability)
        cell.cityTemper.text = String(weatherJson[indexPath.row].celsius)
        
        var image: UIImage? = nil
        
        switch weatherJson[indexPath.row].state {
        case 10:
            image = UIImage(named: "sunny")
        case 11:
            image = UIImage(named: "cloudy")
        case 12:
            image = UIImage(named: "rainy")
        case 13:
            image = UIImage(named: "snowy")
        default:
            print("not provide type")
        }
        
//        print(cell.uiView)
        let tempRect: CGRect = CGRect(x: 75 - (image?.size.width)!/2, y: cell.uiView.frame.size.height/2 - (image?.size.height)!/2, width: (image?.size.width)!, height: (image?.size.height)!)
        let uiImageView: UIImageView = UIImageView(frame: tempRect)
        uiImageView.image = image
        cell.uiView.addSubview(uiImageView)
        
        
        return cell
    }
            
}
