//
//  SignInViewController.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-21.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@objc(SignInViewController)
class SignInViewController: UIViewController, GIDSignInUIDelegate  {
  
  
  
  @IBOutlet weak var signInButton: GIDSignInButton!
  
  var handle: AuthStateDidChangeListenerHandle?
  
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

    GIDSignIn.sharedInstance().uiDelegate = self
    GIDSignIn.sharedInstance().signInSilently()
    handle = Auth.auth().addIDTokenDidChangeListener() { (auth, user) in
      if user != nil {
//                MeasurementHelper.sendLoginEvent()
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
        
      }
    }
    }
  deinit {
    if let handle = handle {
      Auth.auth().removeStateDidChangeListener(handle)
    }
  }
}



