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
  @IBOutlet weak var detailProvinceLabel: UILabel!
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
    setupUserInfo()
    
    view.setGradientBackground(colorOne: colors.black, colorTwo: colors.darkGrey)
    
    detailView.layer.cornerRadius = detailView.frame.height/2
    
    detailImageView.layer.cornerRadius = detailImageView.frame.height/2
    detailImageView.layer.borderWidth = 4
    detailImageView.layer.borderColor = colors.white.cgColor
  }
  
 
  func setupUI() {
    database.reference.child("friendList/\(database.currentUser?.uid ?? "")").observeSingleEvent(of: .value) { (snapshot) in
        guard let userID = self.user?.id else {return}
        guard let value = snapshot.value as? [String:String] else {return}
        if value.keys.contains(userID) {
            self.connectButton.setTitle("Send Message", for: UIControlState.normal)
        }
        }
    }
    
  func setupUserInfo() {

    self.detailNameLabel.text = user?.name
    self.detailCityLabel.text = user?.city
    self.detailProvinceLabel.text = user?.province
    self.detailLinkLabel.text = user?.link
    self.detailDescriptionLabel.text = user?.userDescription
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
//    sender.setTitle("Pending Request", for: UIControlState.disabled)
//    sender.backgroundColor = UIColor.lightGray
//    sender.isEnabled = false
 //   startChat(user: user!)
    if sender.titleLabel?.text == "Send Message" {
        startChat(user: user!)
    } else {
    friendRequest(user: user!)
    }
    
  }
    
    func friendRequest(user: User){
        let senderID = database.currentUser?.uid ?? ""
        let senderName = database.currentUser?.displayName ?? ""
        let request = ["name":senderName,"pending":true,"rejected":false] as [String : Any]
        database.reference.child("friendRequest/\(user.id)/\(senderID)").setValue(request)
    }
    
    func startChat(user: User){

        let addNew = [user.id:user.name]
        database.reference.child("activeChats/\(database.currentUser?.uid ?? "")/").updateChildValues(addNew)


    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "detailToChatSegue" {
            let vc = segue.destination as! ChatController
            vc.user = self.user
        }
    }
  
}




