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
    var posts = [Post]()
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
                self.collectionView.refreshControl?.endRefreshing()
                self.collectionView.reloadData()
                
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
        
        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        var height = 8 + 40 + 8 + width
        height += 110
        return CGSize(width: width, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.5
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}
