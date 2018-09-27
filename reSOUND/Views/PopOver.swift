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
//  var contentView: UIView?
  @IBOutlet var contentView: UIView!
  
//  @IBOutlet weak var saveButton: gradientButton!
//  @IBOutlet weak var lyricistButton: gradientButton!
//  @IBOutlet weak var engineerButton: gradientButton!
//  @IBOutlet weak var producerButton: gradientButton!
//  @IBOutlet weak var singerButton: gradientButton!
  
  var gradient = CAGradientLayer()
  var pressed = false
  
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
  
//  func loadViewFromNib() -> UIView? {
//    let bundle = Bundle(for: type(of: self))
//    let nib = UINib(nibName: nibName, bundle: bundle)
//    return nib.instantiate(withOwner: self, options: nil).first as? UIView
//  }

  
  //Pragma Mark: Actions
  
//  @IBAction func pressed(_ sender: gradientButton) {
//  }
//  
//  @IBAction func lyricistButtonPressed(_ sender: gradientButton) {
//  }
//  
//  @IBAction func engineerButtonPressed(_ sender: gradientButton) {
//  }
//  
//  @IBAction func producerButtonPressed(_ sender: gradientButton) {
//  }
//  
//  @IBAction func singerButtonPressed(_ sender: gradientButton) {
//  }
}

