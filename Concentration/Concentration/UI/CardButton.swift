//
//  CardButton.swift
//  Concentration
//
//  Created by 정하민 on 17/06/2019.
//  Copyright © 2019 JHM. All rights reserved.
//

import UIKit

class CardButton: UIButton { // 가로 세로 잡힌 카드 UI 리턴
    
    required init(_ rect:CGRect) {
        super.init(frame: rect)
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
