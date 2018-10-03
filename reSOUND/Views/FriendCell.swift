//
//  FriendCellTableViewCell.swift
//  reSOUND
//
//  Created by Wiljay Flores on 2018-10-02.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class FriendCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var skillsLabel: UILabel!
    var user: User?
    var skills = [String]()
    let ref = Database.database().reference()
    let storageRef = Storage.storage().reference()
    
    func configureCell(name: String, id: String) {
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 5
        containerView.layer.cornerRadius = 5
        nameLabel.text = name
        
        ref.child("users/\(id)").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? [String:String] else {return}
            self.user = User(name: value["name"]!, city: value["city"]!, province: value["province"]!, email: value["email"]!, id: value["id"]!, userDescription: value["userDescription"]!, link: value["link"]!)
            
            let usersProfileImageRef = self.storageRef.child("users/\(self.user?.id ?? "    ")/usersProfileImage.jpg")
            self.locationLabel.text = (self.user?.city)! + ", " + (self.user?.province)!

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
           self.skills = []
            self.ref.child("skills/\(self.user?.id ?? "")").observeSingleEvent(of: .value, with: { (snapshot) in
                guard let value = snapshot.value as? [String:Bool] else {return}
                for key in value.keys {
                    if value[key] == true {
                        self.skills.append(key)
                    }
                }
                self.skillsLabel.text = self.skills.joined(separator: ", ")
            })

        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
