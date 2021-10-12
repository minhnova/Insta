//
//  FeedCell.swift
//  Insta
//
//  Created by Phai Hoang on 10/2/21.
//

import Foundation
import UIKit
import SnapKit

class FeedCell: UICollectionViewCell {
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    
    private lazy var userNameButton:UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Venom", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        bt.addTarget(self, action: #selector(didTapUserName), for: .touchUpInside)
        return bt
    }()
    
    private lazy var likeButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        bt.tintColor = .black
        return bt
    }()
    
    private lazy var commentButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
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
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    
    private let likesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "1 like"
        lbl.font = UIFont.boldSystemFont(ofSize: 13)
        return lbl
    }()
    
    private let captionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Some test caption for now..."
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    private let postTimeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "2 days ago..."
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func didTapUserName() {
        print("DEBUG - did tap user name")
    }
}
