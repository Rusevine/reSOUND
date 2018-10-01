//
//  ChatController.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-21.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase



class ChatController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UITextViewDelegate {


    @IBOutlet weak var chatTextView: UITextView!
    @IBOutlet weak var chatTableView: UITableView!
  @IBOutlet weak var chatSendButton: UIButton!
  
  var messages: [DataSnapshot]! = []
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
    chatTextView.layer.cornerRadius = 5
    chatSendButton.layer.cornerRadius = 5
    chatTableView.layer.cornerRadius = 5
    chatTextView.text = "Enter Message"
    chatTextView.textColor = UIColor.lightGray
    chatTextView.delegate = self
    view.setGradientBackground(colorOne: colors.black, colorTwo: colors.darkGrey)
 
    configurePaths()
    configureDatabase()
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
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
      strongSelf.chatTableView.scrollToRow(at: IndexPath(item:strongSelf.messages.count-1, section: 0), at: .bottom, animated: true)
    })
  }
    
    

  
  @IBAction func chatSendButtonPressed(_ sender: UIButton) {
    guard let text = chatTextView.text else {fatalError()}
    sendMessage(text: text)
    chatTextView.text = ""
  }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let message = textView.text else { return true }
        
        let newLength = message.characters.count + text.characters.count - range.length
        return newLength <= self.msglength.intValue
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
    let timestamp = message["timestamp"] ?? ""
    
    cell.configureCell(senderID: senderID, sender: sender, message: text, timestamp: timestamp)
  
    return cell
}

  //Pragma Mark send massage
  
  func sendMessage(text: String) {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy HH:mm"
    let today = Date()
    let timestamp = formatter.string(from: today)
    
    
    let message = ["sender": database.currentUser?.displayName,
                   "text" : text, "senderID": database.currentUser?.uid, "timestamp": timestamp]
    let key = database.reference.child(sendPath!).childByAutoId().key
    database.reference.child("\(sendPath!)/\(key)").setValue(message)
    database.reference.child("\(receivePath!)/\(key)").setValue(message)
    }
  

    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Enter Message" && textView.textColor == .lightGray)
        {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Enter Message"
            textView.textColor = .lightGray
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    

}
