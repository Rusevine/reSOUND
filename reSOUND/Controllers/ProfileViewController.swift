//
//  ProfileViewController.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-20.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

  @IBOutlet weak var profileView: UIView!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var cityTextField: UITextField!
  @IBOutlet weak var provinceTextField: UITextField!
  @IBOutlet weak var skillsTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var saveButton: UIButton!
  
  var ref: DatabaseReference!
  //var user: User?

  override func viewDidLoad() {
        super.viewDidLoad()
    
        ref = Database.database().reference()
    }


//  func saveProfile() {
//    var user1 = [String:String]()
//    user1["name"] = nameTextField.text
//    user1["province"] = provinceTextField.text
//    user1["email"] = emailTextField.text
//    user1["city"] = cityTextField.text
//        self.ref.child("users/U001/name").setValue(user1["name"])
//        self.ref.child("users/U001/province").setValue(user1["province"])
//        self.ref.child("users/U001/city").setValue(user1["city"])
//        self.ref.child("users/U001/email").setValue(user1["email"])
//  }
  
  func newProfile() {
    var user1 = [String:String]()
    
    let userID = Auth.auth().currentUser!.uid
    user1["name"] = nameTextField.text
    user1["province"] = provinceTextField.text
    user1["email"] = emailTextField.text
    user1["city"] = cityTextField.text
    self.ref.child("users").child("\(userID)/name").setValue(user1["name"])
    self.ref.child("users").child("\(userID)/province").setValue(user1["province"])
    self.ref.child("users").child("\(userID)/city").setValue(user1["city"])
    self.ref.child("users").child("\(userID)/email").setValue(user1["email"])
    
  }
  
  @IBAction func saveButtonPressed(_ sender: Any) {
   // saveProfile()
    newProfile()
  }


  
  
  }




