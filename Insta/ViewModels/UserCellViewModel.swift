//
//  UserCellViewModel.swift
//  Insta
//
//  Created by Phai Hoang on 10/8/21.
//

import Foundation


struct UserCellViewModel {
    private let user: User
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var fullname: String {
        return user.fullname
    }
    
    var username: String {
        return user.username
    }
    
    init(user: User) {
        self.user = user
    }
}
