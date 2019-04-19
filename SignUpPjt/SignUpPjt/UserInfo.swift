//
//  UserInfo.swift
//  SignUpPjt
//
//  Created by 정하민 on 19/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import Foundation

class UserInfo {
    var userId: String?
    var userPw: String?
    var userIntro: String?
    
    var Date: String?
    
    static let sharedInstance = UserInfo()
}
