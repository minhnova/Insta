//
//  ProfileController.swift
//  Insta
//
//  Created by Phai Hoang on 10/2/21.
//

import Foundation
import UIKit

private let cellIdentifier = "ProfileCell"
private let headerIdentifier = "ProfileHeader"

class ProfileController: UICollectionViewController {
    
    // MARK: - Properties
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - API
    
    
    // MARK: - Helpers
    func configureUI() {
        collectionView.backgroundColor = .systemCyan
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
    }
    
    // MARK: - Actions

}

// MARK: - UICollectionView Datasource

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ProfileCell else {
            fatalError("Can not init cell")
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as? ProfileHeader else {
            fatalError("Can not init cell")
        }

        return cell
    }
}


// MARK: - UICollectionView Delegate

extension ProfileController {
    
}

// MARK: - UICollectionView DataFlow

extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 2) / 3
        
        return CGSize(width: width, height: width)
    }
    
}
