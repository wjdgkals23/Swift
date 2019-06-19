//
//  CardButton.swift
//  Concentration
//
//  Created by 정하민 on 17/06/2019.
//  Copyright © 2019 JHM. All rights reserved.
//

import UIKit

class CardButton: UIButton { // 가로 세로 잡힌 카드 UI 리턴
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
//        self.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
        self.layer.cornerRadius = 3
        self.contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
}
