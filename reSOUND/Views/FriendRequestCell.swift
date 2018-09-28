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
            self.user = User(name: value["name"]!, city: value["city"]!, province: value["province"]!, email: value["email"]!, id: value["id"]!)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
