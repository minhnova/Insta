//
//  ProfileController.swift
//  Insta
//
//  Created by Phai Hoang on 10/2/21.
//

import Foundation
import UIKit
import Firebase

private let cellIdentifier = "ProfileCell"
private let headerIdentifier = "ProfileHeader"

class ProfileController: UICollectionViewController {
  
    
    // MARK: - Properties
    var user: User
    var posts = [Post]()
    
    private lazy var logoutButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Logout", for: .normal)
        bt.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        bt.tintColor = .black
        return bt
    }()
    
    // MARK: - View Lifecycle
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        checkIfUserIsFollowed()
        fetchUserStats()
        fetchUserPosts()
    }
    
    // MARK: - API
    
    func checkIfUserIsFollowed() {
        UserService.checkUserIsFollowed(uid: self.user.uid) { status in
            self.user.isFollowed = status
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserStats() {
        UserService.getUserStats(uid: self.user.uid) { userStats in
            self.user.stats = userStats
            self.collectionView.reloadData()
            print("DEBUG - user Stat \(userStats)")
        }
    }
    
    func fetchUserPosts() {
        self.showLoader(true)
        PostService.fetchPosts(forUser: self.user.uid) { posts in
            self.showLoader(false)
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
    @objc func logOut() {
        do {
            try Auth.auth().signOut()
            let vc = LoginController()
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(UINavigationController(rootViewController: vc))
            
        } catch {
            print("debug")
        }
    }
    
    
    // MARK: - Helpers
    func configureUI() {
        collectionView.backgroundColor = .systemCyan
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        let rightBarButton = UIBarButtonItem(customView: logoutButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        //navigationController?.navigationBar.addb
        
    }
    
    // MARK: - Actions
    
}

extension ProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        feed.post = self.posts[indexPath.row]
        navigationController?.pushViewController(feed, animated: true)
    }
}

// MARK: - UICollectionView Datasource

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ProfileCell else {
            fatalError("Can not init cell")
        }
        cell.postViewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as? ProfileHeader else {
            fatalError("Can not init cell")
        }
        
        header.delegate = self
        header.viewModel = ProfileHeaderViewModel(user: user)
        
        
        return header
    }
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

// MARK: - ProfileHeaderDelegate

extension ProfileController: ProfileHeaderDelegate {
    func header(_ profileHeader: ProfileHeader, didTapActionFor user: User) {
        print("DEBUG - ProfileHeaderDelegate")
        
        if user.isCurrentUser {
            print("DEBUG - edit current user")
        } else if (user.isFollowed) {
            UserService.unFollow(uid: self.user.uid) { error in
                self.user.isFollowed = false
                self.collectionView.reloadData()
                print("DEBUG -  did unFollow ")
            }
            print("DEBUG - unfollow")
            
        } else {
            UserService.follow(uid: self.user.uid) { error in
                self.user.isFollowed = true
                self.collectionView.reloadData()
                print("DEBUG -  did follow ")
            }
            
        }
    }
    
}
