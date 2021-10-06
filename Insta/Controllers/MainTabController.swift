//
//  MainTabController.swift
//  Insta
//
//  Created by Phai Hoang on 10/2/21.
//

import Foundation
import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        configreViewControllers()
        //checkIfUserIsLoggedIn()
        //logOut()
    }
    // MARK: - API
    
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("debug")
        }
    }
    
    // MARK: - Helpers
    
    func configreViewControllers() {
        view.backgroundColor = .white
        let flowLayout = UICollectionViewFlowLayout()
        
        let feed = templateNavigationController(seletedImage:  #imageLiteral(resourceName: "home_selected")
                                                , unSelectedImage: #imageLiteral(resourceName: "home_unselected"), rootViewController: FeedController(collectionViewLayout: flowLayout))
        let search = templateNavigationController(seletedImage:  #imageLiteral(resourceName: "search_selected")
                                                  , unSelectedImage: #imageLiteral(resourceName: "search_unselected"),
                                                  rootViewController:
                                                    SearchController())
        let imageSelector = templateNavigationController(seletedImage:  #imageLiteral(resourceName: "plus_unselected")
                                                         , unSelectedImage: #imageLiteral(resourceName: "plus_unselected"),
                                                         rootViewController:
                                                           ImageSelectorController())
        let noti = templateNavigationController(seletedImage:  #imageLiteral(resourceName: "like_selected")
                                                , unSelectedImage: #imageLiteral(resourceName: "like_unselected"),
                                                rootViewController:
                                                  NotificationController())
        let profileFlowLayout = UICollectionViewFlowLayout()
        let profile = templateNavigationController(seletedImage:  #imageLiteral(resourceName: "profile_selected")
                                                   , unSelectedImage: #imageLiteral(resourceName: "profile_unselected"),
                                                   rootViewController:
                                                     ProfileController(collectionViewLayout: profileFlowLayout))
        viewControllers = [feed, search, imageSelector, noti, profile]
    }
    
    func setUpView() {
        self.tabBar.backgroundColor = .systemGray
        tabBar.tintColor = .label
        //navigationController?.bac
    }
    
    func templateNavigationController(seletedImage:UIImage, unSelectedImage:UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.selectedImage = seletedImage
        nav.tabBarItem.image = unSelectedImage
        nav.navigationBar.tintColor = .blue
        nav.tabBarController?.tabBar.tintColor = .systemCyan
        return nav
    }
}
