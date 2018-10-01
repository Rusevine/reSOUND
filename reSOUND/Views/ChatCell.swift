//
//  ChatCell.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-21.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase

class ChatCell: UITableViewCell {
  
 
    
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
   // var senderID: String!
  //  @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
 //   @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    func configureCell(senderID: String, sender: String, message: String) {
        senderLabel.text = sender
        messageLabel.text = "   " + message + "   "
        
        
//        if senderID != Auth.auth().currentUser?.uid {
//            rightConstraint.constant = 0
//            leftConstraint.constant = 199
//            messageLabel.backgroundColor = UIColor.lightGray
//            messageLabel.textAlignment = NSTextAlignment.right
//            senderLabel.textAlignment = NSTextAlignment.right
//        } else {
//            leftConstraint.constant = 0
//            rightConstraint.constant = 199
//            messageLabel.backgroundColor = UIColor.blue
//            messageLabel.textAlignment = NSTextAlignment.left
//            senderLabel.textAlignment = NSTextAlignment.left
//          }
        
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
