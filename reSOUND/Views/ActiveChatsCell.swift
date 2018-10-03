//
//  ActiveChatsCell.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-25.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ActiveChatsCell: UITableViewCell {

    @IBOutlet weak var lastSentLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var activeChatsLabel: UILabel!
  var user: User?
  var ref = Database.database().reference()
  let storageRef = Storage.storage().reference()
  
  func configureCell(name: String, id: String) {
    profileImageView.layer.masksToBounds = true
    profileImageView.layer.cornerRadius = 5
    containerView.layer.cornerRadius = 5
    activeChatsLabel.text = name
    ref.child("users/\(id)").observeSingleEvent(of: .value) { (snapshot) in
      guard let value = snapshot.value as? [String:String] else {return}
      self.user = User(name: value["name"]!, city: value["city"]!, province: value["province"]!, email: value["email"]!, id: value["id"]!, userDescription: value["userDescription"]!, link: value["link"]!)
        
        let usersProfileImageRef = self.storageRef.child("users/\(self.user?.id ?? "    ")/usersProfileImage.jpg")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        usersProfileImageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                
                self.profileImageView.image = image
                self.user?.image = image
            }
            guard let uid = Auth.auth().currentUser?.uid else {return}
            self.ref.child("chats/\(uid)/\(self.user?.id ?? "")").queryLimited(toLast: 1).observe(.childAdded, with: { (snapshot) in
                let value = snapshot.value as! [String:String]
                let time = value["timestamp"]
                self.lastSentLabel.text = time
            })
        }
    }
  }

  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
