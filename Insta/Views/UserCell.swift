//
//  UserCell.swift
//  Insta
//
//  Created by Phai Hoang on 10/8/21.
//

import Foundation
import UIKit
import SnapKit

class UserCell: UITableViewCell {
    
    // MARK: - Properties
    
    var viewModel: UserCellViewModel? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.backgroundColor = .lightGray
        iv.setDimensions(height: 48, width: 48)
        iv.layer.cornerRadius = 48 / 2
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Venom"
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        return lb
    }()
    
    private let fullnameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Eddie Brock"
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textColor = .lightGray
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(12)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let viewModel = self.viewModel else { return }
        self.fullnameLabel.text = viewModel.fullname
        self.usernameLabel.text = viewModel.username
        profileImageView.kf.setImage(with: viewModel.profileImageUrl)
    }
    
}

