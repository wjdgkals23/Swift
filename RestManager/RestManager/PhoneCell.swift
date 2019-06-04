//
//  PhoneCell.swift
//  RestManager
//
//  Created by 정하민 on 04/06/2019.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import UIKit

class PhoneCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
