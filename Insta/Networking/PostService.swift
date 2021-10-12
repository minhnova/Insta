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
    
    static func uploadPost(caption: String, image: UIImage, completion: @escaping (FireStoreCompletion)) {
        
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image, folder: "posts_images") { imgUrl in
            let data:[ String:Any] = ["caption":caption,
                                      "timestamp": Timestamp(date: Date()),
                                      "likes":0,
                                      "imageUrl":imgUrl,
                                      "ownerID":userUid]
            COLLECTION_POST.addDocument(data: data, completion: completion)
        }
        
    }
    
    static func fetchAllPosts() {
        COLLECTION_POST.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach { post in
                print("DEBUG - Post \(post.data())")
            }
        }
    }
    
}
