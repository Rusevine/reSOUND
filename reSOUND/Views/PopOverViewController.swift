//
//  PopOverViewController.swift
//  reSOUND
//
//  Created by Kyla  on 2018-09-25.
//  Copyright © 2018 Kyla . All rights reserved.
//

import UIKit


class PopOverViewController: UIViewController, UIPopoverControllerDelegate {

  @IBOutlet weak var engineerButton: UIButton!
  @IBOutlet weak var lyricistButton: UIButton!
  @IBOutlet weak var producerButton: UIButton!
  @IBOutlet weak var singerButton: UIButton!
//  @IBOutlet weak var skillsButton: UIButton!
  @IBOutlet weak var popOverView: UIView!
  
  
  var buttonPressed:Bool = true
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  

  //Pragma Mark: PopOver
//  func showFilters(){
//    popoverPresentationController?.delegate = self
//
//    let rect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
//    let popOverView = PopOverViewController(presentedViewController: <#T##UIViewController#>, presenting: <#T##UIViewController?#>)
//
//    popOverView.modalPresentationStyle = UIModalPresentationStyle.popover
//    popOverView.preferredContentSize = CGSizeFromString(rect,rect)
//    present(PopOverViewController, animated: true, completion: nil)
//
//    let popoverPresentationController = popOverView.popoverPresentationController
//    popoverPresentationController?.sourceView = skillsButton
//    popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: skillsButton.frame.size.width, height: skillsButton.frame.size.height)
//
////    popoverPresentationController?.sourceRect = filters_button.frame
//
////    self.presentViewController(filtersVC, animated: true, completion: nil)
//  }

//  func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
//    return .none
//  }
  
  
  //Pragma Mark: Button Actions
  
  
//  @IBAction func skillsButonPressed(_ sender: UIButton) {
//  }
  
  
  @IBAction func engineerButtonPressed(_ sender: UIButton) {
    buttonPressed = !buttonPressed
    if (buttonPressed == true) {
      engineerButton.setImage(UIImage(named: "InvertedEngineer.png"), for: .normal)
    } else {
      engineerButton.setImage(UIImage(named: "Engineer.png"), for: .normal)
    }
  }
  
  @IBAction func lyricistButtonPressed(_ sender: Any) {
    buttonPressed = !buttonPressed
    if (buttonPressed == true) {
      lyricistButton.setImage(UIImage(named: "InvertedLyricist.png"), for: .normal)
    } else {
      lyricistButton.setImage(UIImage(named: "Lyricist.png"), for: .normal)
    }
  }
  
  @IBAction func producerButtonPressed(_ sender: UIButton) {
    buttonPressed = !buttonPressed
    if (buttonPressed == true) {
      producerButton.setImage(UIImage(named: "InvertedProducer.png"), for: .normal)
    } else {
      producerButton.setImage(UIImage(named: "Producer.png"), for: .normal)
    }
  }
  
  @IBAction func singerButtonPressed(_ sender: UIButton) {
    buttonPressed = !buttonPressed
    if (buttonPressed == true) {
      singerButton.setImage(UIImage(named: "InvertedSinger.png"), for: .normal)
    } else {
      singerButton.setImage(UIImage(named: "Singer.png"), for: .normal)
    }
  }
  
  

}
