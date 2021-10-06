//
//  ProfileHeader.swift
//  Insta
//
//  Created by Phai Hoang on 10/6/21.
//

import UIKit
import SnapKit


class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let nameLabel:UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 13)
        lb.text = "Eddie Brock"
        return lb
        
    }()
    
    private lazy var postsLabel:UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.attributedText = attributeText(value: 1, label: "posts")
        return lb
        
    }()
    
    private lazy var followersLabel:UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.attributedText = attributeText(value: 100, label: "followers")
        return lb
        
    }()
    
    private lazy var followingLabel:UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.attributedText = attributeText(value: 12, label: "following")
        return lb
    }()
    
    private lazy var editProfileButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Edit profile", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        bt.layer.borderWidth = 0.5
        bt.layer.cornerRadius = 3
        bt.setTitleColor(.black, for: .normal)
        bt.addTarget(self, action: #selector(handleEditProfileButtonTapped), for: .touchUpInside)
        bt.layer.borderColor = UIColor.lightGray.cgColor
        return bt
    }()
    
    private let gridButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return bt
    }()
    
    private let listButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        bt.tintColor = UIColor(white: 0, alpha: 0.2)
        return bt
    }()
    
    private let bookmarkButton: UIButton = {
        var bt = UIButton(type: .system)
        bt.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        bt.tintColor = UIColor(white: 0, alpha: 0.2)
        return bt
    }()
    
    
    
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(80)
        }
        profileImageView.layer.cornerRadius = 80 / 2
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(12)
        }
        
        let stackView = UIStackView(arrangedSubviews: [postsLabel,followersLabel,followingLabel])
        stackView.distribution = .fillEqually

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.left.equalTo(profileImageView.snp.right).offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(50)
        }
        
        addSubview(editProfileButton)
        editProfileButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.right.equalToSuperview().offset(-24)
            make.left.equalToSuperview().offset(24)
        }
        
        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .lightGray
        
        let buttonStack = UIStackView(arrangedSubviews: [gridButton,listButton,bookmarkButton])
        buttonStack.distribution = .fillEqually
        
        addSubview(topDivider)
        addSubview(bottomDivider)
        addSubview(buttonStack)
        
        buttonStack.snp.makeConstraints { make in
            make.right.left.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        topDivider.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.left.right.equalToSuperview()
            make.top.equalTo(buttonStack.snp.top)
        }

        bottomDivider.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.left.right.equalToSuperview()
            make.top.equalTo(buttonStack.snp.bottom)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    
    // MARK: - Helpers
    
    func attributeText(value: Int, label: String) -> NSAttributedString {
        let attText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attText.append(NSMutableAttributedString(string: label, attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return attText
    }
    
    // MARK: - Actions
    
    @objc func handleEditProfileButtonTapped() {
        print("DEBUG - user tapped!")
    }
}
