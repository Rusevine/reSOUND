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
  @IBOutlet weak var descriptionTextField: UITextField!
  @IBOutlet weak var linkTextField: UITextField!
  @IBOutlet weak var skillsLabel: UILabel!
  
  @IBOutlet weak var profileImageView: UIImageView!
  
  @IBOutlet weak var skillsButton: UIButton!

  @IBOutlet weak var popOverView: UIView!
  @IBOutlet weak var popOverTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var popOverHeightConstraint: NSLayoutConstraint!
  
//  var pressed = false
  let database = DatabaseManager.shared
  var skillsArray = [String]()

  override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    
    view.setGradientBackground(colorOne: colors.black, colorTwo: colors.darkGrey)
    self.nameTextField.attributedPlaceholder = NSAttributedString(string: "enter name",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
    self.cityTextField.attributedPlaceholder = NSAttributedString(string: "enter city",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
    self.provinceTextField.attributedPlaceholder = NSAttributedString(string: "enter province",
                                                                      attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
    self.emailTextField.attributedPlaceholder = NSAttributedString(string: "enter email",
                                                                   attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
    self.descriptionTextField.attributedPlaceholder = NSAttributedString(string: "enter a little description about yourself", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
    self.linkTextField.attributedPlaceholder = NSAttributedString(string: "enter any links to your work if applicable", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
    
    self.profileImageView.layer.masksToBounds = false 
    self.profileImageView.layer.cornerRadius = profileImageView.frame.width/2
    self.profileImageView.clipsToBounds = true
    self.profileImageView.layer.borderWidth = 4
    self.profileImageView.layer.borderColor = colors.white.cgColor
  

    }
    
    func setupUI() {
        skillsButton.layer.cornerRadius = skillsButton.frame.size.height/4
        skillsButton.layer.masksToBounds = true
//        skillsButton.setGradientBackground(colorOne: colors.orange, colorTwo: colors.brightOrange)
    }

  
  func updateProfile() {
    var user = [String:String]()
    let keys = ["name","province","email","city"]
    
    let userID = database.currentUser!.uid
    user["name"] = nameTextField.text
    user["province"] = provinceTextField.text
    user["email"] = emailTextField.text
    user["city"] = cityTextField.text
    
    for key in keys {
        database.reference.child(database.usersPath + "/\(userID)/" + key).setValue(user[key])
    }
    
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
    updateProfile()
  }

  @IBAction func skillsButtonPressed(_ sender: gradientButton) {
    if (sender.pressed == true) {
      popOverTopConstraint.constant +=
        (popOverHeightConstraint.constant * -1)
      sender.setTitle("done", for: UIControlState.normal)
    }  else  {
      popOverTopConstraint.constant -=
        (popOverHeightConstraint.constant * -1)
      sender.setTitle("add skills", for: UIControlState.normal)
    }
    UIView.animate(withDuration: 2.0) {}
  }

  
//  func filterSkills(completion: @escaping ([String])->()){
//    var keys = [String]()
//    var count = 0 {
//      didSet {
//        if count == skillsArray.count{
//          completion(keys)
//        }
//      }
//    }

//  @IBAction func engineerButtonPressed(_ sender: UIButton) {
//    sender.pulsate()
//    sender.flash()
//    }
//
//  @IBAction func lyricistButtonPressed(_ sender: UIButton) {
//    sender.flash()
//  }
//
//  @IBAction func singerButtonPressed(_ sender: UIButton) {
//    sender.pulsate()
//  }
//
//  @IBAction func producerButtonPressed(_ sender: UIButton) {
//    sender.pulsate()
//  }

//  @IBAction func engineerButtonPressed(_ sender: UIButton) {
//    buttonPressed = !buttonPressed
//    if (buttonPressed == true) {
//      engineerButton.setImage(UIImage(named: "InvertedEngineer.png"), for: .normal)
//    } else {
//      engineerButton.setImage(UIImage(named: "Engineer.png"), for: .normal)
//    }
//  }
//  
//  @IBAction func lyricistButtonPressed(_ sender: Any) {
//    buttonPressed = !buttonPressed
//    if (buttonPressed == true) {
//      lyricistButton.setImage(UIImage(named: "InvertedLyricist.png"), for: .normal)
//    } else {
//      lyricistButton.setImage(UIImage(named: "Lyricist.png"), for: .normal)
//    }
//  }
//  
//  @IBAction func producerButtonPressed(_ sender: UIButton) {
//    buttonPressed = !buttonPressed
//    if (buttonPressed == true) {
//      producerButton.setImage(UIImage(named: "InvertedProducer.png"), for: .normal)
//    } else {
//      producerButton.setImage(UIImage(named: "Producer.png"), for: .normal)
//    }
//  }
//  
//  @IBAction func singerButtonPressed(_ sender: UIButton) {
//    buttonPressed = !buttonPressed
//    if (buttonPressed == true) {
//      singerButton.setImage(UIImage(named: "InvertedSinger.png"), for: .normal)
//    } else {
//      singerButton.setImage(UIImage(named: "Singer.png"), for: .normal)
//    }
//  }
  
  }




