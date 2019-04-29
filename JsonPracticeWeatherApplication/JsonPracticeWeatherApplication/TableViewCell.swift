//
//  TableViewCell.swift
//  JsonPracticeWeatherApplication
//
//  Created by 정하민 on 29/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var cellImageView: UIImageView = {
        var imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var imageLabel: UILabel = {
        var label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(cellImageView)
        self.addSubview(imageLabel)
        
        NSLayoutConstraint(item: cellImageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .leftMargin, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: cellImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: cellImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: imageLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .rightMargin, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: imageLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1, constant: 0).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
