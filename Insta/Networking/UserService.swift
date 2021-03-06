//
//  UserService.swift
//  Insta
//
//  Created by Phai Hoang on 10/7/21.
//

import Firebase
typealias FireStoreCompletion = (Error?) -> Void

struct UserService {
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
    
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchAllUser(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            let users = snapshot.documents.map ({ User(dictionary: $0.data())  })
            completion(users)
        }
    }
    
    static func follow(uid: String, completion: @escaping (FireStoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { error in
            
            COLLECTION_FOLLOWERS.document(uid).collection("user-follower").document(currentUid).setData([:], completion: completion)
        }
    }
    
    static func unFollow(uid: String, completion: @escaping (FireStoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-follower").document(currentUid).delete(completion: completion)
        }
    }
    
    static func checkUserIsFollowed(uid: String, completion: @escaping (Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { snapshot, error in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
    
    static func getUserStats(uid: String, completion: @escaping (UserStats) -> Void) {
        
        COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, _ in
            let following = snapshot?.documents.count ?? 0
            
            COLLECTION_FOLLOWERS.document(uid).collection("user-follower").getDocuments { snapshot, _ in
                let follower = snapshot?.documents.count ?? 0
                
                COLLECTION_POST.whereField("ownerID", isEqualTo: uid).getDocuments { snapshot, error in
                    let posts = snapshot?.documents.count ?? 0
                    let userStat = UserStats(followers: follower, following: following, posts: posts)
                    completion(userStat)
                }
                
 
            }
        }
    }
}
