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
//  @IBOutlet weak var popOverView: UIView!
  @IBOutlet weak var popOverTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var popOverHeightConstraint: NSLayoutConstraint!
  
//  var pressed = false
  let database = DatabaseManager.shared
  let storageRef = Storage.storage()
  var skillsArray = [String]()
  var picsArray = [UIImage]()
  var skillSet = ["engineer":false,"lyricist":false,"singer":false,"producer":false]
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
  
  @objc func openImagePicker(_ sender:Any) {
    // Open Image Picker
    self.present(imagePicker, animated: true, completion: nil)
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
//    user["image"] = profileImageView.image
    
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
  
  //////can upload an image to firebase, just not from profileImageView
  func uploadPic() {

    let storage = Storage.storage().reference()
    let tempImageRef = storage.child("tmpDir/tmpImage.jpg")

    let image = UIImage(named: "britney")
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpg"

    tempImageRef.putData(UIImageJPEGRepresentation(image!, 0.8)!, metadata:metaData) { (data, error) in
      if error == nil {
        print("upload successful")
      } else {
        print("error with upload pic")
      }
    }
  }
  
//  func updatePic() {
//    var picture = imagePicker
//    let keys = [URL]()
//
//    print(picsArray)
//    let pictures = database.currentUser!.uid
//    picture!["image"] =
//
//    for key in keys {
//      database.reference.child(database.skillsPath + "/\(pictures)/" + key).setValue(picture[key])
//    }
//  }
  
//  @objc func handlePic() {
//    guard let image = profileImageView.image else { return }
//        self.uploadProfileImage(image) { url in
//          if url != nil {
//            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//            changeRequest?.photoURL = url
//
//            changeRequest?.commitChanges { error in
//              if error == nil {
//                print("User display name changed!")
//
//                self.saveProfilePic( profileImageURL: url!) { success in
//                  if success {
//                    self.dismiss(animated: true, completion: nil)
//                  } else {
//                    self.resetForm()
//                  }
//                }
//              } else {
//                print("Error: \(error!.localizedDescription)")
//                self.resetForm()
//              }
//            }
//          } else {
//            self.resetForm()
//          }
//    }
//  }
//
//  func resetForm() {
//    let alert = UIAlertController(title: "did you fill out all the fields?", message: nil, preferredStyle: .alert)
//    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
//    self.present(alert, animated: true, completion: nil)
//  }
//
//func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
//  guard let uid = Auth.auth().currentUser?.uid else { return }
//  let storageRef = Storage.storage().reference()
//
//  guard let imageData = UIImageJPEGRepresentation(image, 0.75) else { return }
//
//
//  let metaData = StorageMetadata()
//  metaData.contentType = "image/jpg"
//
//  storageRef.putData(imageData, metadata: metaData) { metaData, error in
//    if error == nil, metaData != nil {
//      // You can also access to download URL after upload.
//      storageRef.downloadURL { url, error in
//        completion(url)
//        // success!
//      }
//    } else {
//      // failed
//        completion(nil)
//      }
//    }
//  }
//
//  func saveProfilePic(profileImageURL:URL, completion: @escaping ((_ success:Bool)->())) {
//            let userID = database.currentUser!.uid
//            let databaseRef = Database.database().reference().child("users/\(userID)")
//
//            let userPicture = [
//              "photoURL": profileImageURL.absoluteString
//              ] as [String:Any]
//
//      databaseRef.setValue(userPicture) { error, ref in
//        completion(error == nil)
//      }
//  }
  
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
    uploadPic()
    
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


  //Pragma Mark: Image Picker
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      picker.dismiss(animated: true, completion: nil)
    }
    /////////////
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

      if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
        self.profileImageView.image = pickedImage
      }

      picker.dismiss(animated: true, completion: nil)

    }
/////////////////
//  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//    dismiss(animated: true, completion: nil)
//    var metaData = StorageMetadata()
//    metaData.contentType = "image/jpg"
//    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//      ////get data to firebase
//
//      ///data in memory
//      var data = Data()
//      data = UIImageJPEGRepresentation(pickedImage, 0.8)!
//
//      ///create a reference to the name of the file i want to upload
//      let imageRef = Storage.storage().reference().child("images/" + randomString(20));
//
//      ///upload the file to the path "images/randomString
//      _ = imageRef.putData(data, metadata: nil) { (metadata, error) in
//
//          return
//        }
////        let downLoadURL = metaData.downLoadURL()
////        print(downLoadURL)
//      
//    }
//  }

//  func randomString(_ length: Int) -> String {
//    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//    let len = UInt32(letters.length)
//
//    var randomString = " "
//
//    for _ in 0 ..< length {
//      let rand = arc4random_uniform(len)
//      var nextChar = letters.character(at: Int(rand))
//      randomString += NSString(characters: &nextChar, length: 1) as String
//    }
//    return randomString
//  }
  ////////////////
  
//////////////trying to upload image to firebase from profileImageView
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    profileImageView.image = image
    let userID = database.currentUser!.uid
    let storage = Storage.storage().reference()
    let tempImageRef = storage.child("tmpDir/tmpImage.jpg")
    let storageRef = Storage.storage().reference()

    dismiss(animated: true, completion: nil)
    var data = NSData()
    data = UIImageJPEGRepresentation(profileImageView.image!, 0.8)! as NSData
    // set upload path
    let filePath = "\(Auth.auth().currentUser!.uid)/\("users")"
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpg"
    tempImageRef.child(filePath).putData(data as Data, metadata: metaData){(metaData,error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }else{
        //store downloadURL
        tempImageRef.downloadURL { url, error in
        //store downloadURL at database
          self.database.reference.child(self.database.usersPath + "/\(userID)/")
      }

    }
  }
  }
  
  //////////////
//  func uploadMedia(completion: @escaping (_ url: String?) -> Void) {
//    let storageRef = Storage.storage().reference().child("userPhoto")
//    if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {
//      storageRef.put(uploadData, metadata: nil) { (metadata, error) in
//        if error != nil {
//          print("error")
//          completion(nil)
//        } else {
//          completion((metadata?.downloadURL()?.absoluteString)!))
//          // your uploaded photo url.
//        }
//      }
//    }
  

//  var images = [ImageData]()
//  func postImage() {
//    let uniqueImageIDPath = NSUUID().uuidString
//    let storageRef = Storage.storage().reference().child("images/\(uniqueImageIDPath)")
//
//        if let myImages = UIImageJPEGRepresentation(self.profileImageView.image!, 0.1){
//          storageRef.putData(myImages, metadata: nil, completion: {
//            (metadata, error) in
//            if error != nil{
//              print(error?.localizedDescription)
//            }
//            if let myImageString = metadata?.downloadURL()?.absoluteString{
//                let imageData = ImageData()
//                imageData.imageOne = myImageString
//                self.images.append(imageData)
//                let values = ["imageOneURL": imageData.imageOneURL]
//                let ref = Database.database().reference().child("users")
//                        ref.updateChildValues(values, withCompletionBlock: {
//                          (error, user) in
//              }
//                          if error != nil {
//                            print(error?.localizedDescription)
//                          }
//                        })
//                      }
//  }

  
}




