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
    
        let layout = UICollectionViewFlowLayout()
        
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        
        // The parameter rootViewController: describes the top of the nav stack
        let navController = UINavigationController(rootViewController: userProfileController)
        
        tabBar.tintColor = .black
        
        
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        // Views that will be shown as tabs on the bottom
        viewControllers = [navController, UIViewController()]
        
    }
}
