//
//  CardButtonDumps.swift
//  Concentration
//
//  Created by 정하민 on 19/06/2019.
//  Copyright © 2019 JHM. All rights reserved.
//

import Foundation
import CoreGraphics

struct CardButtonDumps {
    var buttonArr: [CardButton] = [CardButton]()
    
    init(_ col:Int, _ row:Int, _ width:CGFloat) {
        var x = 5
        var y = 0
        let length = Int((Float(width)-10))/col
        
        for _ in 1...row {
            for _ in 1...col {
                buttonArr.append(CardButton.init(frame: CGRect.init(x: x, y: y, width: length, height: length)))
                x += length
            }
            x = 5
            y += length
        }
    }
}
