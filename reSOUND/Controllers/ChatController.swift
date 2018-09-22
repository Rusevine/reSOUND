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
  var ref: DatabaseReference!
  fileprivate var _refHandle: DatabaseHandle!
  var msglength: NSNumber = 30
  
  
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    view.setGradientBackground(colorOne: colors.black, colorTwo: colors.lightGrey)

    chatTextFieldDelegate = self
        configureDatabase()
    
    }

  func configureDatabase() {
    ref = Database.database().reference()
    _refHandle = self.ref.child("chats/U003/U002").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
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
    let cell = self.chatTableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath)
    let messageSnapshot: DataSnapshot! = self.messages[indexPath.row]
    guard let message = messageSnapshot.value as? [String:String] else { return cell }
    let sender = message["sender"] ?? ""
//    cell.textLabel?.text = "sent by: \(sender)"
    let text = message["text"] ?? ""
    cell.textLabel?.text = sender + " : " +  text
  
    return cell
}

  //Pragma Mark send massage
  
  func sendMessage(text: String) {
    
    let message = ["sender": Auth.auth().currentUser?.displayName,
                              "text" : text]
    let key = self.ref.child("chats/U002/U003").childByAutoId().key
    self.ref.child("chats/U002/U003/\(key)").setValue(message)
    self.ref.child("chats/U003/U002/\(key)").setValue(message)
    //    view.endEditing(true)
    }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let text = textField.text else { return true }
    textField.text = ""
    view.endEditing(true)
    sendMessage(text: text)
    return true
  }

}
