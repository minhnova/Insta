//
//  NotificationCell.swift
//  Insta
//
//  Created by Phai Hoang on 10/16/21.
//

import Foundation
import UIKit
import SnapKit

class NotificationCell: UITableViewCell {
    
    // MARK: - Properties
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.setDimensions(height: 48, width: 48)
        iv.layer.cornerRadius = 48 / 2
        return iv
    }()
    
    private let infoLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        lb.text = "Test"
        return lb
    }()
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        let tap = UIGestureRecognizer(target: self, action: #selector(handlePostTapped))
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    private lazy var followButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.configuration = .tinted()
        bt.configuration?.title = "Follow"
        bt.configuration?.cornerStyle = .medium
        bt.configuration?.baseForegroundColor = .systemBlue
        bt.configuration?.baseBackgroundColor = .systemCyan
        bt.addTarget(self, action: #selector(handleFollowTap), for: .touchUpInside)
    
        bt.layer.borderColor = UIColor.lightGray.cgColor
        return bt
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        addSubview(followButton)
        followButton.setDimensions(height: 32, width: 100)
        followButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(12)
        }
        
        addSubview(postImageView)
        postImageView.setDimensions(height: 40, width: 40)
        postImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
        }
        
        followButton.isHidden = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    // MARK: - Actions
    
    @objc func handleFollowTap(){
        
    }
    
    @objc func handlePostTapped(){
        
    }
}
