//
//  CommentInputAccessoryView.swift
//  Insta
//
//  Created by Phai Hoang on 10/13/21.
//

import Foundation
import UIKit

protocol CommentInputAccessoryViewDelegate: AnyObject {
    func didTapPostButton(with text:String)
}

class CommentInputAccessoryView: UIView {
    
    // MARK: - Properties
    weak var delegate: CommentInputAccessoryViewDelegate?
    
    private let commentTextView: CustomTextView = {
        let tv = CustomTextView()
        tv.placeHolderText = "Enter comment here.."
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.isScrollEnabled = false
        tv.shouldCenterPlaceHolder = true
        return tv
    }()
    
    private lazy var postButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Post", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        bt.addTarget(self, action: #selector(handleCommentPost), for: .touchUpInside)
        return bt
    }()
    
    // MARK: - View Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
        postButton.setDimensions(height: 50, width: 50)
        addSubview(postButton)
        postButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(8)
        }
        
        addSubview(commentTextView)
        commentTextView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(8)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(8)
            make.right.equalTo(postButton.snp.left).offset(8)
            
        }
        
        let divider = UIView()
        ///divider.setDimensions(height: self.frame.width, width: 1)
        divider.backgroundColor = .lightGray
        addSubview(divider)
        divider.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    
    // MARK: - Actions
    @objc func handleCommentPost() {
        if commentTextView.text.isEmpty { return }
        self.delegate?.didTapPostButton(with: commentTextView.text)
    }
    
    func clearTextView() {
        self.commentTextView.text = nil
        self.commentTextView.placeHolderLabel.isHidden = false
    }
    
    
}
