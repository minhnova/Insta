//
//  ProfileHeaderViewModel.swift
//  Insta
//
//  Created by Phai Hoang on 10/7/21.
//

import Foundation
import UIKit


struct ProfileHeaderViewModel {
    let user: User
    
    
    var profileUrl: String {
        return user.profileImageUrl
    }
    
    var fullname: String {
        return user.fullname
    }
    
    var followeButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgrounColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    init(user: User) {
        self.user = user
    }
    
    var followerAttText: NSAttributedString {
        return attributeText(value: self.user.stats.followers, label: "followers")
    }
    
    var followingrAttText: NSAttributedString {
        return attributeText(value: self.user.stats.following, label: "following")
    }
    
    var numberfPost: NSAttributedString {
        return attributeText(value: 0, label: "posts")
    }
    
    func attributeText(value: Int, label: String) -> NSAttributedString {
        let attText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attText.append(NSMutableAttributedString(string: label, attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return attText
    }
}
