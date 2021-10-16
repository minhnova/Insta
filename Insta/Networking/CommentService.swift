//
//  CommentService.swift
//  Insta
//
//  Created by Phai Hoang on 10/13/21.
//

import Foundation
import Firebase

struct CommentService {
    
    static func uploadComment(_ comment: String, postID: String, user: User,
                              completion: @escaping(FireStoreCompletion)) {
        let data: [String: Any] = ["comment": comment,
                                   "uid":user.uid,
                                   "timestamp": Timestamp(date: Date()),
                                   "username":user.username,
                                   "profileImageUrl":user.profileImageUrl]
        COLLECTION_POST.document(postID).collection("comments").addDocument(data: data, completion: completion)
    }
    
    static func fetchComment(postID: String,
                              completion: @escaping([Comment]) -> Void) {
        var comments = [Comment]()
        let query = COLLECTION_POST.document(postID).collection("comments").order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let data = change.document.data()
                    let comment = Comment(dictionary: data)
                    comments.append(comment)
                }
            })
            
            completion(comments)
        }
        
    }
}
