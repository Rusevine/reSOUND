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

    let storageRef = Storage.storage().reference(forURL: "gs://resound-f6d2a.appspot.com")
    let imageName = "usersProfileImage"
    let storage = Storage.storage().reference(forURL: "https://firebasestorage.googleapis.com/v0/b/resound-f6d2a.appspot.com/o/users%2Fjpzdur5TYXfqaqLQw02fUMbQqCF2%2FusersProfileImage?alt=media&token=1d2e567d-ca05-42a4-becc-7bbc2e1c78f4")
    let pathReference = Storage.storage().reference("users/\(userID)/usersProfileImage.jpg")

//    let imageURL = storage.child(imageName)
//
//    imageURL.downloadURL(completion: { (url, error) in
//        if error != nil {
//          print(error?.localizedDescription)
//          return
//        }
//        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//          if error != nil {
//            print(error)
//            return
//          }
//          guard let imageData = UIImage(data: data!) else { return }
//          DispatchQueue.main.async {
//            self.usersImageView.image = imageData
//          }
//        }).resume()
//      })
    
    // Create a reference to the file you want to download
    let islandRef = storage.child("users")
    
    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
    islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
      if let error = error {
        // Uh-oh, an error occurred!
      } else {
        // Data for "images/island.jpg" is returned
        let image = UIImage(data: data!)
      }
    }
    
    
  }
  


    

  

  
}
