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
  
 
    
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var senderLabel: UILabel!
    
    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    // var senderID: String!
  //  @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
 //   @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    func configureCell(senderID: String, sender: String, message: String,timestamp: String) {
        senderLabel.text = sender
        timestampLabel.text = "sent on " + timestamp
        messageLabel.layer.masksToBounds = true
        messageLabel.text = message
        messageLabel.layer.cornerRadius = 5
        messageLabel.numberOfLines = 0
        
     //   messageLabel.sizeToFit()
    //    messageLabel.preferredMaxLayoutWidth = self.frame.width * 0.80
        
        if senderID != Auth.auth().currentUser?.uid {
            messageLabel.backgroundColor = UIColor.lightGray
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
