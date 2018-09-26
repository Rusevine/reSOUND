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
  var contentView: UIView?
  


}
//import UIKit
//
//class QuoteView: UIView {
//
//  let nibName = "QuoteView"
//  var contentView: UIView?
//  @IBOutlet weak var imageView: UIImageView!
//  @IBOutlet weak var textLabel: UILabel!
//
//  required init?(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)
//
//    guard let view = loadViewFromNib() else { return }
//    view.frame = self.bounds
//    self.addSubview(view)
//    contentView = view
//  }
//
//  func loadViewFromNib() -> UIView? {
//    let bundle = Bundle(for: type(of: self))
//    let nib = UINib(nibName: nibName, bundle: bundle)
//    return nib.instantiate(withOwner: self, options: nil).first as? UIView
//  }
//}
