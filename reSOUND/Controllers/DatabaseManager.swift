//
//  DatabaseManager.swift
//  reSOUND
//
//  Created by Wiljay Flores on 2018-09-25.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase

class DatabaseManager: NSObject {
    
    private override init() {}
    
    internal static let shared = DatabaseManager()
    let reference = Database.database().reference()
    let currentUser = Auth.auth().currentUser
    
    var friends : [DataSnapshot]! = []
    var requests: [DataSnapshot]! = [] 
    
    let usersPath = "users"
    let skillsPath = "skills"
    
    let name = "name"
    let id = "id"
    let city = "city"
    let province = "province"
    let email = "email"
  
    let userDescription = "userDescription"
    let link = "link"
  
    var usersProfileImage = UIImage()
//    private var usersProfileImage: UIImage!
    init(usersProfileImage:UIImage) {
    self.usersProfileImage = usersProfileImage
  }
  

  
}
