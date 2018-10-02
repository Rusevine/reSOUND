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

    view.setGradientBackground(colorOne: colors.black, colorTwo: colors.darkGrey)
    GIDSignIn.sharedInstance().uiDelegate = self
    GIDSignIn.sharedInstance().signInSilently()
    handle = Auth.auth().addIDTokenDidChangeListener() { (auth, user) in
      if user != nil {
        let database = DatabaseManager.shared
        let userID = database.currentUser!.uid
        database.reference.child("users").observeSingleEvent(of: .value) { (snapshot) in
          let child = snapshot.value as! [String:Any]
          
          if child.keys.contains(userID){
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
          } else {
              self.performSegue(withIdentifier: "signUpSegue", sender: nil)
        }
      }
    }
  }
}
  deinit {
    if let handle = handle {
      Auth.auth().removeStateDidChangeListener(handle)
    }
  }
  
  func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
  }


  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if segue.identifier == "signUpSegue" {
      let vc = segue.destination as! SignUpController
      }
    }
    

}


