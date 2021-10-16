//
//  CommentCell.swift
//  Insta
//
//  Created by Phai Hoang on 10/13/21.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher


class CommentCell: UICollectionViewCell {
    
    // MARK: - Properties
    var commentViewModel: CommentViewModel? {
        didSet { configure() }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let commentLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - API
    
    
    // MARK: - Helpers
    func configureUI() {
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(8)
        }
        
        addSubview(commentLabel)
        commentLabel.numberOfLines = 0
        commentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.right.equalTo(self.snp.right).offset(8)
        }
    }
    
    func configure() {
        guard let viewModel = commentViewModel else { return }
        

        commentLabel.attributedText = viewModel.commentAttText()
        
        if let url = URL(string: viewModel.userProfileImageUrl) {
            profileImageView.kf.setImage(with: url)
        }
        
        
    }
    

    
    // MARK: - Actions
}
