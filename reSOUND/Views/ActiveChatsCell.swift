//
//  ActiveChatsCell.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-25.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase

class ActiveChatsCell: UITableViewCell {

  @IBOutlet weak var activeChatsLabel: UILabel!
  var user: User?
  var ref = Database.database().reference()
  
  func configureCell(name: String, id: String) {
    activeChatsLabel.text = name
    ref.child("users/\(id)").observeSingleEvent(of: .value) { (snapshot) in
      guard let value = snapshot.value as? [String:String] else {return}
      self.user = User(name: value["name"]!, city: value["city"]!, province: value["province"]!, email: value["email"]!, id: value["id"]!, userDescription: value["userDescription"]!, link: value["link"]!)
    }
  }

  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
