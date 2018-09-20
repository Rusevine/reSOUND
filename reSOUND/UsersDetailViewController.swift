//
//  UsersDetailViewController.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-20.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit
import Firebase

class UsersDetailViewController: UIViewController, UIImagePickerControllerDelegate {
  
  @IBOutlet weak var detailView: UIView!
  @IBOutlet weak var detailNameLabel: UILabel!
  @IBOutlet weak var detailCityLabel: UILabel!
  @IBOutlet weak var detailProvinceLabel: UILabel!
  @IBOutlet weak var detailSkillsLabel: UILabel!

  var user: User?
  
  override func viewDidLoad() {
    self.detailNameLabel.text = user?.name
    self.detailCityLabel.text = user?.city
    self.detailProvinceLabel.text = user?.province
  }

}



