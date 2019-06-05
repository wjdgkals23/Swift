//
//  PhoneViewModel.swift
//  RestManager
//
//  Created by 정하민 on 05/06/2019.
//  Copyright © 2019 Appcoda. All rights reserved.
//

import Foundation

class FriendListViewModel {
    
    var friendsViewModel: [FriendViewModel]
    
    init() {
        self.friendsViewModel = [FriendViewModel]()
    }
}

extension FriendListViewModel {
    
    func friendViewModel(at index: Int) -> FriendViewModel {
        return self.friendsViewModel[index]
    }
    
}

struct FriendViewModel {
    let friend: Friend
}

extension FriendViewModel {
    
    var name: String {
        return self.friend.name.full
    }
    
    var email: String {
        return self.friend.email
    }
    
    var pic: String {
        return self.friend.picture.thumbnail
    }
}
