//
//  CutomTableViewCell.swift
//  SimpleTable
//
//  Created by 정하민 on 22/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class CutomTableViewCell: UITableViewCell {
    
    @IBOutlet var leftLabel: UILabel!
    @IBOutlet var rightLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
