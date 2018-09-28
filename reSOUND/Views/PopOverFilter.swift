//
//  PopOverFilter.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-27.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit

class PopOverFilter: UIView {

let nibName = "PopOverFilter"
  @IBOutlet var filterContentView: UIView!
  var gradient = CAGradientLayer()
  var pressed = false
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    Bundle.main.loadNibNamed("PopOverFilter", owner: self, options: nil)
    addSubview(filterContentView)
    filterContentView.frame = self.bounds
    filterContentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
  
  
  
}


