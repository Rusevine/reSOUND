//
//  FriendRequestCell.swift
//  reSOUND
//
//  Created by Wiljay Flores on 2018-09-28.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class FriendRequestCell: UITableViewCell {


    @IBOutlet weak var nameLabel: UILabel!
    var user: User?
    var database = DatabaseManager.shared
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    var skills = [String]()
    let storageRef = Storage.storage().reference()
    
    func configureCell(name: String, id: String) {
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 5
        containerView.layer.cornerRadius = 5
        nameLabel.text = name
        database.reference.child("users/\(id)").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? [String:String] else {return}
            self.user = User(name: value["name"]!, city: value["city"]!, province: value["province"]!, email: value["email"]!, id: value["id"]!, userDescription: value["userDescription"]!, link: value["link"]!)
            
            let usersProfileImageRef = self.storageRef.child("users/\(self.user?.id ?? "    ")/usersProfileImage.jpg")
           // self.locationLabel.text = (self.user?.city)! + ", " + (self.user?.province)!
            
            usersProfileImageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    // Uh-oh, an error occurred!
                } else {
                    // Data for "images/island.jpg" is returned
                    let image = UIImage(data: data!)
                    
                    self.profileImageView.image = image
                    self.user?.image = image
                }
            }

        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func friendAccepted(_ sender: UIButton) {
      //  let values = ["name":nil,"pending": nil, "rejected": nil] as [String : Any]
        let userID = database.currentUser?.uid ?? ""
       // let name = user?.name ?? ""
        let status = ["pending": false, "rejected": false] as [String:Bool]
        
        for key in status.keys {
        database.reference.child("friendRequest/\(userID)/\(user?.id ?? "")/" + key).setValue(status[key])
        }
        
        
        let newFriend = [(user?.id)!:user?.name] as! [String:String]
        database.reference.child("friendList/\(userID)").updateChildValues(newFriend)
        
        database.reference.child("users/\(database.currentUser?.uid ?? "")").observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as! [String:String]
            let id = value["id"] as! String
            let name = value["name"] as! String
            let sender = [id:name]
            self.database.reference.child("friendList/\(self.user?.id ?? "")").updateChildValues(sender)
     }
    }
    
    @IBAction func friendRejected(_ sender: UIButton) {
        let userID = database.currentUser?.uid ?? ""
        let status = ["pending": false, "rejected": true] as [String:Bool]
        for key in status.keys {
        database.reference.child("friendRequest/\(userID)/\(user?.id ?? "")/" + key).setValue(status[key])
        }
    }
}
