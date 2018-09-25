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
      
    }

 

  @IBAction func signUpButtonPressed(_ sender: UIButton) {
  }
  
  
  
}
