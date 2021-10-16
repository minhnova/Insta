//
//  Post.swift
//  Insta
//
//  Created by Phai Hoang on 10/12/21.
//

import Foundation
import Firebase

struct Post {
    
    var caption: String
    var likes: Int
    let imageUrl: String
    let ownerID: String
    let timestamp: Timestamp
    let postId: String
    let ownerUsername: String
    let ownerImageUrl: String
    var didLike = false
    
    init(postId: String, dictionary: [String: Any]) {
        self.postId = postId
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.ownerID = dictionary["ownerID"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.ownerUsername = dictionary["ownerUsername"] as? String ?? ""
        self.ownerImageUrl = dictionary["ownerImageUrl"] as? String ?? ""  
    }
    
}

