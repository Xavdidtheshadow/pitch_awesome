//
//  PitchPipeViewController.swift
//  PitchAwesome
//
//  Created by David Brownman on 9/28/15.
//  Copyright © 2015 DB. All rights reserved.
//

import UIKit

class PitchPipeViewController: UIViewController {
  let tonePlayer = TonePlayer()
  
  @IBAction func playPitch(sender: UIButton!) {
    if let pitch = sender.currentTitle {
      activateButton(sender)
      tonePlayer.playTone(pitch)
    }
  }
  
  @IBAction func stopPitch(sender: UIButton!) {
    if let pitch = sender.currentTitle {
      deactivateButton(sender)
      tonePlayer.stopTone(pitch)
    }
  }
  
  @IBAction func swapButtonCase(sender: UISwitch) {
    for tag in 100...111 {
      let button = view.viewWithTag(tag) as! UIButton
      if sender.on {
        button.setTitle(button.currentTitle?.uppercaseString, forState: .Normal)
      } else {
        button.setTitle(button.currentTitle?.lowercaseString, forState: .Normal)
      }
    }
  }
}
