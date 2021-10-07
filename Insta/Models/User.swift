//
//  User.swift
//  Insta
//
//  Created by Phai Hoang on 10/7/21.
//

import Foundation

struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""   
    }
}
