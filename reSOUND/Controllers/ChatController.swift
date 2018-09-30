//
//  ChatController.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-21.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase



class ChatController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {


  @IBOutlet weak var chatTableView: UITableView!
  @IBOutlet weak var chatTextField: UITextField!
  @IBOutlet weak var chatSendButton: UIButton!
  
  var messages: [DataSnapshot]! = []
  var chatTextFieldDelegate: UITextFieldDelegate?
  var database = DatabaseManager.shared
  fileprivate var _refHandle: DatabaseHandle!
  var msglength: NSNumber = 140
  var user: User?
  var sendPath: String!
  var receivePath: String!
    

  
  
    override func viewWillAppear(_ animated: Bool) {
        
    }
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    view.setGradientBackground(colorOne: colors.black, colorTwo: colors.lightGrey)
    chatTextFieldDelegate = self
    configurePaths()
    configureDatabase()
    
    }
    func configurePaths() {
        let userID = database.currentUser?.uid
        self.sendPath = "chats/\(user?.id ?? "")/\(userID ?? "")"
        self.receivePath = "chats/\(userID ?? "")/\(user?.id ?? "")"
    }

  func configureDatabase() {
    _refHandle = database.reference.child(receivePath!).observe(.childAdded, with: { [weak self] (snapshot) -> Void in
      guard let strongSelf = self else { return }
      strongSelf.messages.append(snapshot)
      strongSelf.chatTableView.insertRows(at: [IndexPath(row: strongSelf.messages.count-1, section: 0)], with: .automatic)
    })
  }
    
    

  
  @IBAction func chatSendButtonPressed(_ sender: UIButton) {
     _ = textFieldShouldReturn(chatTextField)
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text else { return true }

    let newLength = text.characters.count + string.characters.count - range.length
    return newLength <= self.msglength.intValue // Bool
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.chatTableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! ChatCell
    let messageSnapshot: DataSnapshot! = self.messages[indexPath.row]
    guard let message = messageSnapshot.value as? [String:String] else { return cell }
    let sender = message["sender"] ?? ""
//    cell.textLabel?.text = "sent by: \(sender)"
    let text = message["text"] ?? ""
    let senderID = message["senderID"] ?? ""
    
    cell.configureCell(senderID: senderID, sender: sender, message: text)
  
    return cell
}

  //Pragma Mark send massage
  
  func sendMessage(text: String) {
    let message = ["sender": database.currentUser?.displayName,
                   "text" : text, "senderID": database.currentUser?.uid]
    let key = database.reference.child(sendPath!).childByAutoId().key
    database.reference.child("\(sendPath!)/\(key)").setValue(message)
    database.reference.child("\(receivePath!)/\(key)").setValue(message)
    }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let text = textField.text else { return true }
    textField.text = ""
    view.endEditing(true)
    sendMessage(text: text)
    return true
  }

}
