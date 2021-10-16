//
//  PostViewModel.swift
//  Insta
//
//  Created by Phai Hoang on 10/12/21.
//

import Foundation
import UIKit

struct PostViewModel {
    
    var post: Post
    
    var caption: String {
        return post.caption
    }
    var ownerID: String {
        return post.ownerID
    }
    var imageURL: String {
        return post.imageUrl
    }
    
    var likes: Int {
        return post.likes
    }
    
    var likeButtonTintColor: UIColor {
        return post.didLike ? .red : .black
    }
    
    var likeButtonImage: UIImage {
        return post.didLike ? #imageLiteral(resourceName: "like_selected"): #imageLiteral(resourceName: "like_unselected")
    }
    
    var postLikeLabelText: String {
        if (likes <= 1) {
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
