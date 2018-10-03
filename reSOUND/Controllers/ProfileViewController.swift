//
//  ProfileViewController.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-20.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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

  @IBOutlet weak var popOverView: PopOver!
  @IBOutlet weak var popOverTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var popOverHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var signOutButton: gradientButton!
  
  
  
//  var pressed = false
  let database = DatabaseManager.shared
  let storageRef = Storage.storage()
  var skillsArray = [String]()
  var picsArray = [UIImage]()
  var skillSet = ["engineer":false,"lyricist":false,"singer":false,"producer":false,"musician":false,"top liner":false,"listener":false,"composer":false]
  var imagePicker: UIImagePickerController!

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
  
    let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
    profileImageView.isUserInteractionEnabled = true
    profileImageView.addGestureRecognizer(imageTap)
//    profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
//    profileImageView.clipsToBounds = true
    //tapToChangeProfileButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
    
    imagePicker = UIImagePickerController()
    imagePicker.allowsEditing = true
    imagePicker.sourceType = .photoLibrary
    imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
    }
  
    func setupUI() {
        skillsButton.layer.cornerRadius = skillsButton.frame.size.height/4
        skillsButton.layer.masksToBounds = true
//        skillsButton.setGradientBackground(colorOne: colors.orange, colorTwo: colors.brightOrange)
    }

  func updateProfile() {
    var user = [String:String]()
    let keys = ["name","province","email","city", "id","link","userDescription"]
    
    let userID = database.currentUser!.uid
    user["name"] = nameTextField.text
    user["province"] = provinceTextField.text
    user["email"] = emailTextField.text
    user["city"] = cityTextField.text
    user["id"] = userID
    user["link"] = linkTextField.text
    user["userDescription"] = descriptionTextField.text
    
    for key in keys {
        database.reference.child(database.usersPath + "/\(userID)/" + key).setValue(user[key])
    }
  }
  
  func updateSkills() {
    var skill = [String:Bool]()
    let keys = ["Audio Engineer", "Lyricist", "Producer", "Singer","Musician","Top Liner","Listener","Composer"]
    
    print(skillSet)
    let skills = database.currentUser!.uid
    skill["Audio Engineer"] = skillSet["engineer"]
    skill["Lyricist"] = skillSet["lyricist"]
    skill["Producer"] = skillSet["producer"]
    skill["Singer"] = skillSet["singer"]
    skill["Musician"] = skillSet["musician"]
    skill["Top Liner"] = skillSet["top liner"]
    skill["Listener"] = skillSet["listener"]
    skill["Composer"] = skillSet["composer"]
    
    for key in keys {
      database.reference.child(database.skillsPath + "/\(skills)/" + key).setValue(skill[key])
    }
  }
  
    func uploadPic(profileImage: UIImage) {
    let userID = database.currentUser!.uid
    let storage = Storage.storage().reference()
    let tempImageRef = storage.child("users/\(userID)/usersProfileImage.jpg")

    let image = profileImage
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpg"

        tempImageRef.putData(UIImageJPEGRepresentation(image, 0.8)!, metadata:metaData) { (data, error) in
      if error == nil {
        print("upload successful")
      } else {
        print("error with upload pic")
      }
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
    updateSkills()
    updateProfile()
    uploadPic(profileImage: self.profileImageView.image!)
    
  }

  @IBAction func skillsButtonPressed(_ sender: gradientButton) {
    popOverView.profileViewController = self
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

  @IBAction func signOutButtonPressed(_ sender: gradientButton) {
    // [START signout]
    self.dismiss(animated: true, completion: {});
    self.navigationController?.popViewController(animated: true);
    
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
    // [END signout]
  }
  
  //Pragma Mark: Image Picker
  @objc func openImagePicker(_ sender:Any) {
    self.present(imagePicker, animated: true, completion: nil)
  }
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      picker.dismiss(animated: true, completion: nil)
    }
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

      if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
        self.profileImageView.image = pickedImage
      }

      picker.dismiss(animated: true, completion: nil)

    }

}




