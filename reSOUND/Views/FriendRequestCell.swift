//
//  FriendRequestCell.swift
//  reSOUND
//
//  Created by Wiljay Flores on 2018-09-28.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase

class FriendRequestCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    var user: User?
    var database = DatabaseManager.shared
    
    func configureCell(name: String, id: String) {
        nameLabel.text = name
        database.reference.child("users/\(id)").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? [String:String] else {return}
          self.user = User(name: value["name"]!, city: value["city"]!, province: value["province"]!, email: value["email"]!, id: value["id"]!, userDescription: value["userDescription"]!, userLink: value["userLink"]!)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func friendAccepted(_ sender: UIButton) {
        let values = ["pending": false]
        database.reference.child("friendRequest/\(database.currentUser?.uid ?? "")/\(user?.id ?? "")").updateChildValues(values)
        let newFriend = [(user?.id)!:user?.name] as! [String:String]
        database.reference.child("friendList/\(database.currentUser?.uid ?? "")").updateChildValues(newFriend)
    }
    
    @IBAction func friendRejected(_ sender: UIButton) {
    }
}
