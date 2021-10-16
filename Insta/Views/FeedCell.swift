//
//  FeedCell.swift
//  Insta
//
//  Created by Phai Hoang on 10/2/21.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

protocol FeedCellDelegate: AnyObject {
    func cell(_ cell: FeedCell, wantToShowCommentsFor post: Post)
    func cell(_ cell: FeedCell, didLikePost post: Post)
    func cell(_ cell: FeedCell, wantToShowUserProfileFor uid:String)
}

class FeedCell: UICollectionViewCell {
    
    weak var delegate: FeedCellDelegate?
    var postViewModel: PostViewModel? {
        didSet { configure() }
    }
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = UIColor.lightGray
        iv.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(showUserProfile))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    private lazy var userNameButton:UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitleColor(.black, for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        bt.addTarget(self, action: #selector(showUserProfile), for: .touchUpInside)
        return bt
    }()
    
    lazy var likeButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.addTarget(self, action: #selector(handleDidTapComment), for: .touchUpInside)
        bt.tintColor = .black
        return bt
    }()
    
    private lazy var commentButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        bt.addTarget(self, action: #selector(handleCommentButtonTapped), for: .touchUpInside)
        bt.tintColor = .black
        return bt
    }()
    
    private lazy var shareButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        bt.tintColor = .black
        return bt
    }()
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = UIColor.lightGray
        return iv
    }()
    
    private let likesLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 13)
        return lbl
    }()
    
    private let captionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    private let postTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = .lightGray
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.left.equalToSuperview().offset(12)
        }
        profileImageView.layer.cornerRadius = 40 / 2
        
        addSubview(userNameButton)
        userNameButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        
        addSubview(postImageView)
        
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.width.equalToSuperview()
            make.height.equalTo(postImageView.snp.width)
        }
        
        configureStackView()
        
        addSubview(likesLabel)
        likesLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(-4)
            make.leading.equalToSuperview().offset(8)
        }
        
        addSubview(captionLabel)
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(likesLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
        }
        
        addSubview(postTimeLabel)
        postTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
        }
        bringSubviewToFront(userNameButton)
        bringSubviewToFront(profileImageView)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [likeButton,commentButton,shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(120)
            make.top.equalTo(postImageView.snp.bottom)
        }
        self.bringSubviewToFront(likeButton)
        self.bringSubviewToFront(commentButton)
        self.bringSubviewToFront(shareButton)
    }
    
    func configure() {
        guard let post = postViewModel else { return }
        
        if let imgURL = URL(string: post.imageURL) {
            postImageView.kf.setImage(with: imgURL)
        }
        
        self.captionLabel.text = post.caption
        self.likesLabel.text = post.postLikeLabelText
        //self.postTimeLabel.text = post.
        
        self.userNameButton.setTitle(post.ownerUsername, for: .normal)
        
        if let imgURL = URL(string: post.ownerImageUrl) {
            profileImageView.kf.setImage(with: imgURL)
        }
        likeButton.setImage(post.likeButtonImage, for: .normal)
        likeButton.tintColor = post.likeButtonTintColor
        
        
    }
    
    // MARK: - Actions
    @objc func handleCommentButtonTapped() {
        guard let viewModel = postViewModel else { return }
        self.delegate?.cell(self, wantToShowCommentsFor: viewModel.post)
    }

    @objc func showUserProfile() {
        guard let viewModel = postViewModel else { return }
        self.delegate?.cell(self, wantToShowUserProfileFor: viewModel.ownerID)
    }
    
    @objc func handleDidTapComment() {
        guard let viewModel = postViewModel else { return }
        self.delegate?.cell(self, didLikePost: viewModel.post)
    }
}
