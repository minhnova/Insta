//
//  ProfileCell.swift
//  Insta
//
//  Created by Phai Hoang on 10/6/21.
//

import UIKit
import SnapKit
import Kingfisher

class ProfileCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var postViewModel: PostViewModel? {
        didSet { configure() }
    }
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - API
    
    
    // MARK: - Helpers
    func configure() {
        guard let viewModel = postViewModel else { return }
        if let imageUrl = URL(string: viewModel.imageURL) {
            postImageView.kf.setImage(with: imageUrl)
        }
    }
    
    
    // MARK: - Actions
    
}
