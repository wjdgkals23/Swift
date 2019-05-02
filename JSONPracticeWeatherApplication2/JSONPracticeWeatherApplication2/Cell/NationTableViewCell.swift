//
//  NationTableViewCell.swift
//  JSONPracticeWeatherApplication2
//
//  Created by 정하민 on 30/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class NationTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

}
