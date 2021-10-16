//
//  FeedController.swift
//  Insta
//
//  Created by Phai Hoang on 10/2/21.
//

import Foundation
import UIKit

private let reuseIdentifier = "Cell"
class FeedController: UICollectionViewController {
  
    // MARK: - Properties
   private var posts = [Post]() {
       didSet{collectionView.reloadData()}
    }
    var post: Post?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getAllPost()     
    }
    
    // MARK: - API
    
    func getAllPost(){
        guard self.post == nil else { return }
        
        PostService.fetchAllPosts { posts in
            DispatchQueue.main.async {
                self.posts = posts
                self.checkIfUserLikePosts()
                self.collectionView.refreshControl?.endRefreshing()
                self.collectionView.reloadData()
                
            }

        }
    }
    
    func checkIfUserLikePosts() {
        self.posts.forEach { post in
            PostService.checkIfUserLikedPost(post: post) { didLike in
                if let index = self.posts.firstIndex(where: { $0.postId == post.postId }) {
                    self.posts[index].didLike = didLike
                }
                    
            }
        }

    }
    
    // MARK: - Helpers
    
    func setupView() {
        collectionView.backgroundColor = .lightGray
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationItem.title = "Feed"
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresher), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
    
    // MARK: - Actions
    
    @objc func handleRefresher(){
        posts.removeAll()
        getAllPost()
    }
}

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ? posts.count : 1

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FeedCell else {
            fatalError("Cell can not init")
        }
        if let post = self.post {
            cell.postViewModel = PostViewModel(post: post)
        } else {
            cell.postViewModel = PostViewModel(post: posts[indexPath.row])
        }
        
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        var height = 8 + 40 + 8 + width
        height += 110
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}

// MARK: - FeedCellDelegate

extension FeedController: FeedCellDelegate {
    func cell(_ cell: FeedCell, wantToShowUserProfileFor uid: String) {
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func cell(_ cell: FeedCell, wantToShowCommentsFor post: Post) {
        print("DEBUG - FeedCellDelegate")
        
        
        let controller = CommentController(post: post)
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func cell(_ cell: FeedCell, didLikePost post: Post) {
        cell.postViewModel?.post.didLike.toggle()
        if post.didLike {
            PostService.unLikePost(post: post) { _ in
                cell.likeButton.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
                cell.likeButton.tintColor = .black
                cell.postViewModel?.post.likes = post.likes - 1
            }
        } else {
            PostService.likePost(post: post) { _ in
                cell.likeButton.setImage(#imageLiteral(resourceName: "like_selected"), for: .normal)
                cell.likeButton.tintColor = .red
                cell.postViewModel?.post.likes = post.likes + 1
            }
        }
    }
    
    
    
}
