//
//  UsersDetailViewController.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-20.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class UsersDetailViewController: UIViewController, UIImagePickerControllerDelegate {
  
  @IBOutlet weak var detailView: UIView!
  @IBOutlet weak var detailNameLabel: UILabel!
  @IBOutlet weak var detailCityLabel: UILabel!
  @IBOutlet weak var detailSkillsLabel: UILabel!
  @IBOutlet weak var connectButton: UIButton!
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  @IBOutlet weak var detailLinkLabel: UILabel!
  @IBOutlet weak var detailImageView: UIImageView!
  
  var user: User?
  var skills = [String]()
  let database = DatabaseManager.shared
  let storageRef = Storage.storage()
  let usersCollectionViewCell = UsersCollectionViewCell()
  
  override func viewDidLoad() {
    
    setupUI()
    checkPending()
    setupUserInfo()
    
    view.setGradientBackground(colorOne: colors.black, colorTwo: colors.darkGrey)
    
    detailImageView.layer.cornerRadius = detailImageView.frame.height/2
    detailImageView.layer.borderWidth = 4
    detailImageView.layer.borderColor = colors.white.cgColor
  }
  
 
  func setupUI() {
    guard let userID = self.user?.id else {return}
    database.reference.child("friendList/\(database.currentUser?.uid ?? "")").observeSingleEvent(of: .value) { (snapshot) in
        guard let value = snapshot.value as? [String:String] else {return}
        if value.keys.contains(userID) {
            self.connectButton.setTitle("Send Message", for: UIControlState.normal)
            }
        }
    }
    func checkPending() {
        guard let userID = self.user?.id else {return}
        database.reference.child("friendRequest/\(userID)/\(database.currentUser?.uid ?? "")").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? [String:Any] else {return}
            let pending = value["pending"] as? Bool
            let rejected = value["rejected"] as? Bool
            if pending == true || rejected == true {
                self.connectButton.setTitle("Pending Request", for: UIControlState.disabled)
                self.connectButton.backgroundColor = UIColor.lightGray
                self.connectButton.isEnabled = false
            }
        }
    }
    
  func setupUserInfo() {

    self.detailNameLabel.text = user?.name
    self.detailCityLabel.text = (user?.city)! + ", " + (user?.province)!
    self.detailLinkLabel.text = user?.link
    self.detailDescriptionLabel.text = "Bio: " + (user?.userDescription)!
    self.detailImageView.image = user?.image 
    
    database.reference.child((database.skillsPath) + "/" + (user?.id)!).observeSingleEvent(of: .value, with: { (snapshot) in
        guard let value = snapshot.value as? [String:Bool] else {return}
        for key in value.keys {
            if value[key] == true {
                self.skills.append(key)
            }
        }
        self.detailSkillsLabel.text = self.skills.joined(separator: ", ")
    })
  }

  
  //#Pragma Mark Actions
  
  @IBAction func connectButtonPressed(_ sender: UIButton) {
    
    if sender.titleLabel?.text == "Send Message" {
        startChat(user: user!)
    } else {
    friendRequest(user: user!)
    sender.setTitle("Pending Request", for: UIControlState.disabled)
    sender.backgroundColor = UIColor.lightGray
    sender.isEnabled = false
    
  }
}
    
    func friendRequest(user: User){
        let senderID = database.currentUser?.uid ?? ""
        let senderName = database.currentUser?.displayName ?? ""
        let request = ["name":senderName,"pending":true,"rejected":false] as [String : Any]
        database.reference.child("friendRequest/\(user.id)/\(senderID)").setValue(request)
    }
    
    func startChat(user: User){

        let receiver = [user.id:user.name]
    
        database.reference.child("activeChats/\(database.currentUser?.uid ?? "")/").updateChildValues(receiver)
        
        database.reference.child("users/\(database.currentUser?.uid ?? "")").observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as! [String:String]
            let id = value["id"] as! String
            let name = value["name"] as! String
            let sender = [id:name]
            self.database.reference.child("activeChats/\(user.id)/").updateChildValues(sender)
        }
        
        performSegue(withIdentifier: "detailToChatSegue", sender: nil)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "detailToChatSegue" {
            let vc = segue.destination as! ChatController
            vc.user = self.user
        }
    }
  
}




