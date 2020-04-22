//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by Fabrício Soares on 18/04/20.
//  Copyright © 2020 Fabrício Soares. All rights reserved.
//

import FirebaseAuth
import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if let index = viewControllers?.firstIndex(of: viewController) {
            if index == 2 {
                
                let layout = UICollectionViewFlowLayout()
                let photoSelectorController = PhotoSelectorViewController(collectionViewLayout: layout)
                
                
                let photoSelectorNavigationController = UINavigationController(rootViewController: photoSelectorController)
                
                
                photoSelectorNavigationController.modalPresentationStyle = .fullScreen
                
                
                present(photoSelectorNavigationController, animated: true)
                
                return false
            }
        }
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        if Auth.auth().currentUser == nil {
            // loginController has to presented after the main tab bar controller is loaded
            DispatchQueue.main.async {
                let loginController = LoginController()
                
                let navController = UINavigationController(rootViewController: loginController)
                
                navController.modalPresentationStyle = .fullScreen
                
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        tabBar.tintColor = .black
        
        // Views that will be shown as tabs on the bottom
        viewControllers = [
            navController(image: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected")),
            navController(image: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected")),
            navController(image: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected")),
            navController(image: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected")),
            navController(image: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        ]
        
        // modify tab bar item insets
        for item in tabBar.items ?? [] {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func navController(
        image: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()
    ) -> UINavigationController {
        let viewController = UINavigationController(rootViewController: rootViewController)
        viewController.tabBarItem.image = image
        viewController.tabBarItem.selectedImage = selectedImage
        return viewController
    }
}
