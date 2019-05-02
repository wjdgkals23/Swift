//
//  WeatherTableTableViewCell.swift
//  JSONPracticeWeatherApplication2
//
//  Created by 정하민 on 02/05/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherView: UIImageView!
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var rainProb: UILabel!
    @IBOutlet weak var cityTemper: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
