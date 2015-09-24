//
//  SongButton.swift
//  PitchAwesome
//
//  Created by David Brownman on 9/23/15.
//  Copyright © 2015 DB. All rights reserved.
//

import UIKit

class SongButton: UIButton {
  let selectedColor = UIColor(red: 9, green: 80, blue: 208, alpha: 1)
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    setBackgroundImage(getSelectedButtonImage(), forState: .Selected)
    tintColor = UIColor.blackColor()
  }
  
  func getSelectedButtonImage() -> UIImage {
    let rect = CGRectMake(0, 0, 60, 60)
    UIGraphicsBeginImageContext(CGSize(width: 60, height: 60))
    selectedColor.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
}
