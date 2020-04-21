//
//  UserProfileController.swift
//  InstagramFirebase
//
//  Created by Fabrício Soares on 18/04/20.
//  Copyright © 2020 Fabrício Soares. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase
import UIKit

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        navigationItem.title = "loading..."
        fetchUser()
        
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        setupLocalOutButton()
        
    }
    
    fileprivate func setupLocalOutButton() {
        // .withRenderingMode(.alwaysOriginal) will prevent tinting the image blue
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear") .withRenderingMode(.alwaysOriginal) , style: .plain, target: self, action: #selector(handleLogOut))
        
    }
    
    @objc func handleLogOut() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (action) in
            
            
            do {
                try Auth.auth().signOut()
                
                let navController = UINavigationController(rootViewController: LoginController())
                
                navController.modalPresentationStyle = .overFullScreen
                
                self.present(navController, animated: true, completion: nil)
                
                
            } catch {
                print(error)

            }
            
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print("canceled ")
        }))
        
        present(alertController,animated: true, completion: nil)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
        header.backgroundColor = .green
        return header
    }
    
    // Asks the delegate for the size of the header view in the specified section.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    // Fetch user data from firebase
    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { snapshot in
            
            let dictionary = snapshot.value as? [String: Any]
            let username = dictionary?["username"]
            self.navigationItem.title = username as? String
            
            
        }) { err in
            print("Failed to fetch user: ", err)
        }
    }
}
