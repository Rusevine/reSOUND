//
//  UsersCollectionViewCell.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-20.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class UsersCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imageContainer: UIView!
  @IBOutlet weak var placeHolderView: UIView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  
  @IBOutlet weak var usersImageView: UIImageView!
  @IBOutlet weak var provinceLabel: UILabel!
    var user: User?
    var id = User.self
  let database = DatabaseManager.shared
  let storageRef = Storage.storage().reference()


  
  func configureCell(withUser user:User){
    self.user = user
    nameLabel.text = user.name
    addressLabel.text = user.city + ","
    provinceLabel.text = user.province
    
    
    placeHolderView.layer.cornerRadius = placeHolderView.frame.height/2
    imageContainer.layer.cornerRadius = 5
    
    usersImageView.layer.cornerRadius = usersImageView.frame.height/2
    usersImageView.layer.borderWidth = 4
    usersImageView.layer.borderColor = colors.white.cgColor
    


    let usersProfileImageRef = self.storageRef.child("users/\(user.id)/usersProfileImage.jpg")

    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
    usersProfileImageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
      if let error = error {
        // Uh-oh, an error occurred!
      } else {
        // Data for "images/island.jpg" is returned
        let image = UIImage(data: data!)

        self.usersImageView.image = image
        self.user?.image = image
      }
    }

  }

}
