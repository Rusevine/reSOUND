//
//  ProfileViewController.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-20.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate {

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
//  @IBOutlet weak var popOverView: UIView!
  @IBOutlet weak var popOverTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var popOverHeightConstraint: NSLayoutConstraint!
  
//  var pressed = false
  let database = DatabaseManager.shared
  var skillsArray = [String]()
  var skillSet = ["engineer":false,"lyricist":false,"singer":false,"producer":false]

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
    let keys = ["name","province","email","city", "id"]
    
    let userID = database.currentUser!.uid
    user["name"] = nameTextField.text
    user["province"] = provinceTextField.text
    user["email"] = emailTextField.text
    user["city"] = cityTextField.text
    user["id"] = userID
    
    for key in keys {
        database.reference.child(database.usersPath + "/\(userID)/" + key).setValue(user[key])
    }
  }
  
  func updateSkills() {
    var skill = [String:Bool]()
    let keys = ["Audio Engineer", "Lyricist", "Producer", "Singer"]
    
    print(skillSet)
    let skills = database.currentUser!.uid
    skill["Audio Engineer"] = skillSet["engineer"]
    skill["Lyricist"] = skillSet["lyricist"]
    skill["Producer"] = skillSet["producer"]
    skill["Singer"] = skillSet["singer"]
    
    for key in keys {
      database.reference.child(database.skillsPath + "/\(skills)/" + key).setValue(skill[key])
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
    updateSkills()
    updateProfile()
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

 
//  func filterSkills(completion: @escaping ([String])->()){
//    var keys = [String]()
//    var count = 0 {
//      didSet {
//        if count == skillsArray.count{
//          completion(keys)
//        }
//      }
//    }

  //Pragma Mark: Image Picker
  
  @IBAction func didTapAddPhoto(_ sender: AnyObject) {
    print("did tap add photo button worked")
    let picker = UIImagePickerController()
    picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate //maybe fix this line to just self if not working
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
      picker.sourceType = UIImagePickerControllerSourceType.camera
    } else {
      picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
    }
    present(picker, animated: true, completion: nil)
  }
  
//  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//    picker.dismiss(animated: true, completion: nil)
//    guard let uid = Auth.auth().currentUser?.uid else { return }
//    // if it's a photo from the library, not an image from the camera
//    if #available(iOS 8.0, *), let referenceURL = info[UIImagePickerControllerReferenceURL] as? URL {
//      let assets = PHAsset.fetchAssets(withALAssetURLs: [referenceURL], options: nil)
//      let asset = assets.firstObject
//      let imageFile = contentEditingInput?.fullSizeImageURL
//      let filePath = "\(uid)/\(Int(Date.timeIntervalSinceReferenceDate * 1000))/\((referenceURL as AnyObject).lastPathComponent!)"
//      guard let strongSelf = self else { return }
//      self.database.reference.child(filePath)
//        .putFile(from: imageFile!, metadata: nil) { (metadata, error) in
//          if let error = error {
//            let nsError = error as NSError
//            print("Error uploading: \(nsError.localizedDescription)")
//            return
//          }
//          strongSelf.sendMessage(withData: [Constants.MessageFields.imageURL:
//            strongSelf.reference.child((metadata?.path)!).description])
//    })
//  } else {
//  guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
//  let imageData = UIImageJPEGRepresentation(image, 0.8)
//  let imagePath = "\(uid)/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
//  let metadata = StorageMetadata()
//  metadata.contentType = "image/jpeg"
//  self.storageRef.child(imagePath)
//  .putData(imageData!, metadata: metadata) { [weak self] (metadata, error) in
//  if let error = error {
//  print("Error uploading: \(error)")
//  return
//  }
//  guard let strongSelf = self else { return }
//  strongSelf.sendMessage(withData: [Constants.MessageFields.imageURL: strongSelf.storageRef.child((metadata?.path)!).description])
//  }
//  }
//}

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion:nil)
  }

}




