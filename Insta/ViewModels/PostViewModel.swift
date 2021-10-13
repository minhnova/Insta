//
//  PostViewModel.swift
//  Insta
//
//  Created by Phai Hoang on 10/12/21.
//

import Foundation
import UIKit

struct PostViewModel {
    
    private let post: Post
    
    var caption: String {
        return post.caption
    }
    
    var imageURL: String {
        return post.imageUrl
    }
    
    var likes: Int {
        return post.likes
    }
    
    var postLikeLabelText: String {
        if (likes != 1) {
            return "\(post.likes) like"
        } else {
            return "\(post.likes) likes"
        }
    }
    
    var ownerImageUrl: String {
        return post.ownerImageUrl
    }
    
    var ownerUsername: String {
        return post.ownerUsername
    }

    
    init(post: Post) {
        self.post = post
    }
    
    
}
