//
//  AuthenticationService.swift
//  Insta
//
//  Created by Phai Hoang on 10/4/21.
//

import Foundation
import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImg: UIImage
}

struct AuthService {
    
    static func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping (Error?) -> Void) {
        print("DEBUG - credential \(credentials)")
        
        ImageUploader.uploadImage(image: credentials.profileImg, folder: "profile_images") { imgUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if let error = error {
                    print("DEBUG - Failed to register user: \(error.localizedDescription)")
                    return
                }
                guard let userID = result?.user.uid else { return }
                
                let data: [String:Any] = ["email":credentials.email,
                                         "uid":userID,
                                         "fullname":credentials.fullname,
                                         "username":credentials.username,
                                         "profileUrl":imgUrl]
                Firestore.firestore().collection("user").document(userID).setData(data, completion: completion)
            }
        }
        
    }
}
