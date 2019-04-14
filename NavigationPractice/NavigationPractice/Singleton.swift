//
//  Singleton.swift
//  NavigationPractice
//
//  Created by 정하민 on 14/04/2019.
//  Copyright © 2019 정하민. All rights reserved.
//

import Foundation

class UserInfo {
    static let shared: UserInfo = UserInfo()
    
    var name: String?
    var age: String?
}
