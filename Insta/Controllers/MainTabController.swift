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
    // MARK: - Properties
    var user:User? {
        didSet {
            guard let user = user else { return }
            configreViewControllers(withUser: user)
        }
    }
    // MARK: - View Lifecycle
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        fetchUser()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfUserIsLoggedIn()
    }
    // MARK: - API
    
    func fetchUser() {
        UserService.fetchUser { user in
            DispatchQueue.main.async {
                self.user = user
            }
            
        }
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let vc = LoginController()
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(UINavigationController(rootViewController: vc))
            }

        }
    }

    
    // MARK: - Helpers
    
    func configreViewControllers(withUser: User) {
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
        let profileVC = ProfileController(user: withUser)
        let profile = templateNavigationController(seletedImage:  #imageLiteral(resourceName: "profile_selected")
                                                   , unSelectedImage: #imageLiteral(resourceName: "profile_unselected"),
                                                   rootViewController:profileVC)
        viewControllers = [feed, search, imageSelector, noti, profile]
    }
    
    func setUpView() {
        self.tabBar.backgroundColor = .white
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
