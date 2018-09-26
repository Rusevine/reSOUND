//
//  gradientButton.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-26.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit

class gradientButton: UIButton {

  var pressed = false
  let defaultColors = [colors.startBlue.cgColor, colors.endBlue.cgColor]
  let tappedColors = [colors.white.cgColor, colors.white.cgColor]
  var gradientLayer: CAGradientLayer = CAGradientLayer()
  
  // MARK: Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Preparation
  
  private func setup() {
    
    // Styling
    
    self.gradientLayer.frame = self.bounds
    layer.insertSublayer(gradientLayer, at: 0)
    applyGradient(colors: defaultColors)
    self.layer.insertSublayer(gradientLayer, at: 0)
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
    gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
    self.gradientLayer.cornerRadius = 5
    self.titleLabel?.layer.zPosition = 20
    self.setTitleColor(UIColor.white, for: .normal)
    
    // Actions
    addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
  }
  
  // MARK: Helpers
  
  private func applyGradient(colors: [CGColor]) {
    gradientLayer.colors = colors
    gradientLayer.frame = bounds
  }
  
  private func applyOriginal(colors: [CGColor]) {
    gradientLayer.colors = colors
    gradientLayer.frame = bounds
  }
  
  // MARK: Touch Handling
  
  @objc private func touchUpInside() {
    if (!pressed) {
      flash()
      applyGradient(colors: tappedColors)
      self.setTitleColor(colors.fontBlue, for: .normal)
      self.pressed = true
      
    } else {
      flash()
      applyOriginal(colors: defaultColors)
      self.setTitleColor(colors.white, for: .normal)
      self.pressed = false
      
    }
  }

}
