//
//  Phone.swift
//  RestManager
//
//  Created by 정하민 on 05/06/2019.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import Foundation

struct FriendAPIResponse: Codable{
    let results: [Friend]
}

struct Friend: Codable {
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
        
        var full: String {
            get {
                return self.title.capitalized + ". " + self.first.capitalized + " " + self.last.capitalized
            }
        }
    }
    
    struct Picture: Codable {
        let large: String
        let medium: String
        let thumbnail: String
    }
    
    let name: Name
    let email: String
    let picture: Picture
}
