//
//  CardLine.swift
//  Concentration
//
//  Created by 정하민 on 17/06/2019.
//  Copyright © 2019 JHM. All rights reserved.
//

import UIKit

class CardLine: UIStackView { // 설정한 열의 수에 따른 카드를 쌓은 Vertical Card Stack 반환
    
    private var colInd: Int
    private var colCnt: Int
    private var width: CGFloat
    private var height: CGFloat
    
    required init(_ colCnt:Int, _ colInd:Int, _ width:CGFloat, _ height:CGFloat, _ rect:CGRect) {
        self.colCnt = colCnt
        self.colInd = colInd
        self.width = width
        self.height = height
        super.init(frame: rect)
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .fill
        self.contentMode = .scaleToFill
        self.frame.size.width = width
        self.frame.size.height = height
        
        let cardBtn:CardButton = CardButton.init(CGRect.init(x: 0, y: 0, width: 30, height: 40))
        
        for _ in 1...self.colCnt {
            self.addSubview(cardBtn)
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let leadingCon = NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: self.superview, attribute: .leading, multiplier: 1.0, constant: 20)
        
        self.superview?.addConstraint(leadingCon)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
