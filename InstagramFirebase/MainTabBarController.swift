//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by Fabrício Soares on 18/04/20.
//  Copyright © 2020 Fabrício Soares. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainTabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            navController(image: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected")),
            navController(image: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected")),
            navController(image: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected")),
            navController(image: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected")),
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
