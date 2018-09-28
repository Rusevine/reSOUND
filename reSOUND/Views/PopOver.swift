//
//  PopOver.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-26.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit

class PopOver: UIView {

  let nibName = "PopOver"
  @IBOutlet var contentView: UIView!
  
  @IBOutlet weak var singerButtonXib: gradientButton!
  @IBOutlet weak var producerButtonXib: gradientButton!
  @IBOutlet weak var engineerButtonXib: gradientButton!
  @IBOutlet weak var lyricistButtonXib: gradientButton!
  
  
  var gradient = CAGradientLayer()
  var pressed = false
  var skillsArray = [String]()
  var profileViewController: ProfileViewController?
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    Bundle.main.loadNibNamed("PopOver", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//    guard let view = loadViewFromNib() else { return }
//    view.frame = self.bounds
//    self.addSubview(view)
//    contentView = view
  }
  
 
  @IBAction func addSkillsToProfile(_ sender: gradientButton) {
    print("add skills to profile button pressed")
    
//    self.skillsLabel.text = "singer"
//    var user = [String:String]()
//    let keys = ["Audio Engineer","Singer","Producer","Lyricist"]
//
//    if (sender.pressed == true) {
//
//      //      self.skillsLabel.text = skillsArray.index(of: sender.currentTitle!)
//      if skillsArray.contains(sender.currentTitle!){
//        if let index = skillsArray.index(of: sender.currentTitle!) {
//          skillsArray.remove(at: index)
//        } else {
//          self.skillsArray.append(sender.currentTitle!)
//        }
//        //        for key in keys {
//        //          database.reference.updateChildValues(database.usersPath +"/\(skills)/" + key).updateValue(user[key])
//        //          database.reference.child(database.usersPath + "/\(skills)/" + key).updateValue(user[key])
//        //        }
//      }
//    }
  }




}

