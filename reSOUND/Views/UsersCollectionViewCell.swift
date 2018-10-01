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
  let storageRef = Storage.storage()

  
  func configureCell(withUser user:User){
    self.user = user
    nameLabel.text = user.name
    addressLabel.text = user.city + ","
    provinceLabel.text = user.province
    
//    usersImageView.image = user.usersProfileImage
    
    placeHolderView.layer.cornerRadius = placeHolderView.frame.height/2
    imageContainer.layer.cornerRadius = 5
    
    usersImageView.layer.cornerRadius = usersImageView.frame.height/2
    usersImageView.layer.borderWidth = 4
    usersImageView.layer.borderColor = colors.white.cgColor
    
    //    self.usersProfileImage = usersProfileImage
    // Create a reference to the file you want to download
    //    let islandRef = storageRef.child("images/island.jpg")
    
    let userID = database.currentUser!.uid
    var user = UIImageView()

    let storageRef = Storage.storage().reference()
    let usersProfileImageRef = storageRef.child("users/usersProfileImage")
    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
    usersProfileImageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
      if error != nil {
        print("error in getting image")
      } else {
        // Data for "images/island.jpg" is returned
        let image = UIImage(data: data!)
//        self.usersImageView = image
//        var grabImage = UIImageView(data: data!)
//        self.usersImageView = grabImage!
      }
    }
    
//    let dbRef = database.reference().child("users")
//    dbRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
//      // Get download URL from snapshot
//      let downloadURL = snapshot.value() as! String
//      // Create a storage reference from the URL
//      let storageRef = storage.referenceFromURL(downloadURL)
//      // Download the data, assuming a max size of 1MB (you can change this as necessary)
//      storageRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
//        // Create a UIImage, add it to the array
//        let pic = UIImage(data: data)
//        picArray.append(pic)
//      }
//    })
 

//    self.databaseRef.child("users").child(id!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
//      // check if user has photo
//      if snapshot.hasChild("userPhoto"){
//        // set image locatin
//        let filePath = "\(userID!)/\("userPhoto")"
//        // Assuming a < 10MB file, though you can change that
//        self.storageRef.child(filePath).dataWithMaxSize(10*1024*1024, completion: { (data, error) in
//
//          let userPhoto = UIImage(data: data!)
//          self.userPhoto.image = userPhoto
//        })
//      }
//    })
    

  }
  

  
}
