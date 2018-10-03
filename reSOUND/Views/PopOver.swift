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
  
  @IBOutlet weak var composerButtonXib: gradientButton!
  
  @IBOutlet weak var musicianButtonXib: gradientButton!
  
  @IBOutlet weak var topLinerButtonXib: gradientButton!
  
  @IBOutlet weak var listenerButtonXib: gradientButton!
  
  
  
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
    if let textss = profileViewController?.skillsLabel.text {
      var texts = textss
      if let buttonTitle = sender.currentTitle {
        let color = sender.currentTitleColor
        if (color.isEqual(colors.fontBlue)) {
          if let pVC = profileViewController {
            print("button on")
            texts.append(" \((sender.titleLabel?.text)!)")
            pVC.skillsLabel.text = texts
            pVC.skillSet[buttonTitle] = true
          }
        } else if (color.isEqual(colors.white)){
          if let proVC = profileViewController {
            print("button off")
            let newSt = texts.replacingOccurrences(of: " \(buttonTitle)", with: "")
            proVC.skillsLabel.text = newSt
            proVC.skillSet[buttonTitle] = false

          }
        }
      }
      }
  
  }
  
}

