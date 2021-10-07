//
//  ProfileHeaderViewModel.swift
//  Insta
//
//  Created by Phai Hoang on 10/7/21.
//

import Foundation


struct ProfileHeaderViewModel {
    let user: User
    
    var profileUrl: String {
        return user.profileImageUrl
    }
    
    var fullname: String {
        return user.fullname
    }
    
    init(user: User) {
        self.user = user
    }
}
