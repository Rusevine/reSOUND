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
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var saveButton: UIButton!
  
  @IBOutlet weak var skillsButton: UIButton!
  @IBOutlet weak var engineerButton: UIButton!
  @IBOutlet weak var lyricistButton: UIButton!
  @IBOutlet weak var singerButton: UIButton!
  @IBOutlet weak var producerButton: UIButton!
  
  
  
  
  var ref: DatabaseReference!
  //var user: User?

  override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        ref = Database.database().reference()
    }
    
    func setupUI() {
        skillsButton.layer.cornerRadius = skillsButton.frame.size.height/2
        skillsButton.layer.masksToBounds = true
        skillsButton.setGradientBackground(colorOne: colors.orange, colorTwo: colors.brightOrange)
        saveButton.layer.cornerRadius = saveButton.frame.size.height/2
        saveButton.layer.masksToBounds = true
        saveButton.setGradientBackground(colorOne: colors.orange, colorTwo: colors.brightOrange)
        
        engineerButton.layer.cornerRadius = engineerButton.frame.size.height/2
        engineerButton.layer.masksToBounds = true
        engineerButton.setGradientBackground(colorOne: colors.orange, colorTwo: colors.brightOrange)
        lyricistButton.layer.cornerRadius = lyricistButton.frame.size.height/2
        lyricistButton.layer.masksToBounds = true
        lyricistButton.setGradientBackground(colorOne: colors.orange, colorTwo: colors.brightOrange)
        singerButton.layer.cornerRadius = singerButton.frame.size.height/2
        singerButton.layer.masksToBounds = true
        singerButton.setGradientBackground(colorOne: colors.orange, colorTwo: colors.brightOrange)
        producerButton.layer.cornerRadius = producerButton.frame.size.height/2
        producerButton.layer.masksToBounds = true
        producerButton.setGradientBackground(colorOne: colors.orange, colorTwo: colors.brightOrange)
        
        view.setGradientBackground(colorOne: colors.black, colorTwo: colors.lightGrey)
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
  
  func animateBackgroundColor() {
    UIView.animate(withDuration: 15, delay: 0, options: [.autoreverse, .curveLinear, .repeat], animations: {
      let x = -(self.profileView.frame.width - self.view.frame.width)
      self.profileView.transform = CGAffineTransform(translationX: x, y: 0)
      })
  }
  
  //#Pragma Mark Actions
  @IBAction func saveButtonPressed(_ sender: Any) {
   // saveProfile()
    newProfile()
  }


  @IBAction func skillsButtonPressed(_ sender: UIButton) {
  }
  
  @IBAction func engineerButtonPressed(_ sender: UIButton) {
    sender.pulsate()
    sender.flash()
    
   
  

    }
  
  @IBAction func lyricistButtonPressed(_ sender: UIButton) {
    sender.flash()
  }
  
  @IBAction func singerButtonPressed(_ sender: UIButton) {
    sender.pulsate()
  }
  
  @IBAction func producerButtonPressed(_ sender: UIButton) {
    sender.pulsate()
  }
  
  
  
  }




