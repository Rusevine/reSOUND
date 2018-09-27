//
//  SignUpController.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-25.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase


class SignUpController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var signUpName: UITextField!
  @IBOutlet weak var signUpEmail: UITextField!
  @IBOutlet weak var signUpCity: UITextField!
  @IBOutlet weak var signUpProvince: UITextField!
  @IBOutlet weak var signUpLink: UITextField!
  
  
  var user: User?
  var userName  = Auth.auth().currentUser!
 
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.signUpName.text = userName.displayName
      self.signUpEmail.text = userName.email
      
      //for circle image view 
//      self.imageView.layer.borderWidth = 1
//      self.imageView.layer.borderColor = colors.fontBlue.cgColor
//      self.imageView.layer.masksToBounds = false
//      self.imageView.layer.cornerRadius = imageView.frame.height/2
//      self.imageView.clipsToBounds = true

      view.setGradientBackground(colorOne: colors.black, colorTwo: colors.darkGrey)
      
//      self.signUpName.attributedPlaceholder = NSAttributedString(string: "enter name",
//                                                                    attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
//      self.signUpCity.attributedPlaceholder = NSAttributedString(string: "enter city",
//                                                                    attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
//      self.signUpProvince.attributedPlaceholder = NSAttributedString(string: "enter province",
//                                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
//      self.signUpEmail.attributedPlaceholder = NSAttributedString(string: "enter email",
//                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
//      self.signUpLink.attributedPlaceholder = NSAttributedString(string: "enter any links to your work",
//                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
    }

 

  @IBAction func signUpButtonPressed(_ sender: UIButton) {
  }
  
  
  
}
