//
//  PopOverSignUp.swift
//  reSOUND
//
//  Created by Kyla  on 2018-10-02.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit

class PopOverSignUp: UIView {

  let nibName = "PopOverSignUp"

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var singerButton: gradientButton!
   @IBOutlet weak var producerButton: gradientButton!
  @IBOutlet weak var engineerButton: gradientButton!
  @IBOutlet weak var lyricistButton: gradientButton!
  @IBOutlet weak var composerButton: gradientButton!
  @IBOutlet weak var musicianButton: gradientButton!
  @IBOutlet weak var topLinerButton: gradientButton!
  @IBOutlet weak var listenerButton: gradientButton!
  
  var gradient = CAGradientLayer()
    var pressed = false
    var skillsArray = [String]()
    var signUpController: SignUpController?

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  
      Bundle.main.loadNibNamed("PopOverSignUp", owner: self, options: nil)
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
      if let textss = signUpController?.signUpSkills.text {
        var texts = textss
        if let buttonTitle = sender.currentTitle {
          let color = sender.currentTitleColor
          if (color.isEqual(colors.fontBlue)) {
            if let pVC = signUpController {
              print("button on")
              texts.append(" \((sender.titleLabel?.text)!)")
              pVC.signUpSkills.text = texts
              pVC.skillSet[buttonTitle] = true
            }
          } else if (color.isEqual(colors.white)){
            if let proVC = signUpController {
              print("button off")
              let newSt = texts.replacingOccurrences(of: " \(buttonTitle)", with: "")
              proVC.signUpSkills.text = newSt
              proVC.skillSet[buttonTitle] = false
  
            }
          }
        }
      }
  
    }
  
}


