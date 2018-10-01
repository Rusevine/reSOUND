//
//  User.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-20.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit

class User: NSObject {

  var name: String
  var city: String
  var province: String
  var email: String
  var id: String
  
  var link: String
  var userDescription: String

  
  init(name: String, city: String, province: String, email: String, id: String, userDescription: String, link: String) {
    self.name = name
    self.city = city
    self.province = province
    self.email = email
    self.id = id
    self.link = link
    self.userDescription = userDescription

  }

}
