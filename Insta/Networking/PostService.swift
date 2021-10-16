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
    
    static func likePost(post: Post, completion: @escaping (FireStoreCompletion)) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_POST.document(post.postId).updateData(["likes": post.likes + 1])
        COLLECTION_POST.document(post.postId).collection("post-likes").document(userId).setData([:]) { _ in
            COLLECTION_USERS.document(userId).collection("user-likes").document(post.postId).setData([:], completion: completion)
        }
    }
    
    static func unLikePost(post: Post, completion: @escaping (FireStoreCompletion)) {
        guard post.likes > 0 else { return }
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_POST.document(post.postId).updateData(["likes": post.likes - 1])
        COLLECTION_POST.document(post.postId).collection("post-likes").document(userId).delete { _ in
            COLLECTION_USERS.document(userId).collection("user-likes").document(post.postId).delete(completion: completion)
        }
    }
    
    static func checkIfUserLikedPost(post: Post, completion: @escaping (Bool) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(userId).collection("user-likes").document(post.postId).getDocument { snapshot, _ in
            guard let didLike = snapshot?.exists else { return }
            completion(didLike)
        }
        
    }
    
}
