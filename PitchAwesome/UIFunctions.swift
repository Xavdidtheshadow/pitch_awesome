//
//  UIFunctions.swift
//  PitchAwesome
//
//  Created by David Brownman on 11/8/15.
//  Copyright © 2015 DB. All rights reserved.
//

import UIKit

func activateButton(sender: UIButton!) {
  sender.backgroundColor = UIColor(red:0.04, green:0.31, blue:0.82, alpha:1.0)
  // changing text color doesn't work for a mysterious reason
  sender.tintColor = UIColor.yellowColor()
}

func deactivateButton(sender: UIButton!) {
  sender.backgroundColor = UIColor.lightGrayColor()
  sender.tintColor = UIColor.blackColor()
}