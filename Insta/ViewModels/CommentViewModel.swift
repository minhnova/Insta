//
//  CommentViewModel.swift
//  Insta
//
//  Created by Phai Hoang on 10/14/21.
//

import Foundation
import UIKit

class CommentViewModel {
    
    private let comment: Comment
    
    var commentText: String { return comment.commentText }
    
    var username: String { return comment.username }
    
    var userProfileImageUrl: String { return comment.profileImageUrl }
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    func commentAttText() -> NSAttributedString {
        let attText = NSMutableAttributedString(string: "\(comment.username)  ", attributes: [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 14)])
        attText.append(NSAttributedString(string: comment.commentText, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        return attText
    }
    
    func size(forWidth width:CGFloat) -> CGSize {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.text = comment.commentText
        lb.lineBreakMode = .byWordWrapping
        lb.setWidth(width)
        return lb.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
