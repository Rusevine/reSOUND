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
  
  var user: User?
  var skills = [String]()
  let database = DatabaseManager.shared
  
  override func viewDidLoad() {
    
    setupUI()
    setupUserInfo()

  }
  
 
  func setupUI() {
    view.setGradientBackground(colorOne: colors.black, colorTwo: colors.lightGrey)
    
    connectButton.layer.cornerRadius = connectButton.frame.size.height/2
    connectButton.layer.masksToBounds = true
    connectButton.setGradientBackground(colorOne: colors.orange, colorTwo: colors.brightOrange)

  }
    
  func setupUserInfo() {

    self.detailNameLabel.text = user?.name
    self.detailCityLabel.text = user?.city
    self.detailProvinceLabel.text = user?.province
    
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
    startChat(user: self.user!)
  }
    
    func startChat(user: User){
        
        let addNew = [user.id:user.name]
        database.reference.child("activeChats/\(database.currentUser?.uid ?? "")/").updateChildValues(addNew)
        
        
    }
  
}




