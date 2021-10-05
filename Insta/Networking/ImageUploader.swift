//
//  ImageUploader.swift
//  Insta
//
//  Created by Phai Hoang on 10/4/21.
//

import FirebaseStorage
import UIKit

struct ImageUploader {
    
    static func uploadImage(image:UIImage, folder: String,  completion:@escaping (String) -> Void) {
        guard let imgData = image.jpegData(compressionQuality: 0.75) else { return }
        let fileName = UUID().uuidString
        
        let ref = Storage.storage().reference(withPath: "/\(folder)/\(fileName)")
        ref.putData(imgData, metadata: nil) { metaData, error in
            if let error = error {
                print("Error \(error)")
                return
            }
            
            ref.downloadURL { url, error in
                guard let imgUrl = url?.absoluteString else { return }
                
                completion(imgUrl)
                
            }
        }
                
    }
}
