//
//  PostService.swift
//  Insta
//
//  Created by Phai Hoang on 10/11/21.
//

import Foundation
import UIKit
import Firebase

struct PostService {
    
    static func uploadPost(caption: String, image: UIImage, user: User,  completion: @escaping (FireStoreCompletion)) {
        
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image, folder: "posts_images") { imgUrl in
            let data:[ String:Any] = ["caption":caption,
                                      "timestamp": Timestamp(date: Date()),
                                      "likes":0,
                                      "imageUrl":imgUrl,
                                      "ownerID":userUid,
                                      "ownerUsername": user.username,
                                      "ownerImageUrl": user.profileImageUrl]
            COLLECTION_POST.addDocument(data: data, completion: completion)
        }
        
    }
    
    static func fetchAllPosts(completion: @escaping ([Post])-> Void) {
        COLLECTION_POST.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            
            completion(posts)
        }
    }
    
    static func fetchPosts(forUser userID: String, completion: @escaping ([Post])-> Void) {
        let query = COLLECTION_POST
            .whereField("ownerID", isEqualTo: userID)
        
        query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            var posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            posts.sort {
                $0.timestamp.seconds > $1.timestamp.seconds
            }
            
            completion(posts)
        }
    }
    
}
