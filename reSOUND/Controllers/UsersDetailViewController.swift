//
//  UsersDetailViewController.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-20.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase

class UsersDetailViewController: UIViewController, UIImagePickerControllerDelegate {
  
  @IBOutlet weak var detailView: UIView!
  @IBOutlet weak var detailNameLabel: UILabel!
  @IBOutlet weak var detailCityLabel: UILabel!
  @IBOutlet weak var detailProvinceLabel: UILabel!
  @IBOutlet weak var detailSkillsLabel: UILabel!
  @IBOutlet weak var connectButton: UIButton!
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  @IBOutlet weak var detailLinkLabel: UILabel!
  
  
  var user: User?
  var skills = [String]()
  let database = DatabaseManager.shared
  
  override func viewDidLoad() {
    
    setupUI()
    setupUserInfo()
    
    view.setGradientBackground(colorOne: colors.black, colorTwo: colors.darkGrey)


  }
  
 
  func setupUI() {
  }
    
  func setupUserInfo() {

    self.detailNameLabel.text = user?.name
    self.detailCityLabel.text = user?.city
    self.detailProvinceLabel.text = user?.province
    self.detailLinkLabel.text = user?.userLink
    self.detailDescriptionLabel.text = user?.userDescription
    
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
    friendRequest(user: user!)
  }
    func friendRequest(user: User){
        let senderID = database.currentUser?.uid ?? ""
        let senderName = database.currentUser?.displayName ?? ""
        let request = ["name":senderName,"pending":true,"rejected":false] as [String : Any]
        database.reference.child("friendRequest/\(user.id)/\(senderID)").setValue(request)
    }
    
//    func startChat(user: User){
//
//        let addNew = [user.id:user.name]
//        database.reference.child("activeChats/\(database.currentUser?.uid ?? "")/").updateChildValues(addNew)
//
//
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "detailToChatSegue" {
//            let vc = segue.destination as! ChatController
//            vc.user = self.user
//        }
//    }
  
}




