//
//  UIFunctions.swift
//  PitchAwesome
//
//  Created by David Brownman on 11/8/15.
//  Copyright © 2015 DB. All rights reserved.
//

import UIKit

func activateButton(sender: UIButton!) {
  sender.backgroundColor = UIColor.blueColor()
  sender.tintColor = UIColor.yellowColor()
}

func deactivateButton(sender: UIButton!) {
  sender.backgroundColor = UIColor.lightGrayColor()
  sender.tintColor = UIColor.blackColor()
}