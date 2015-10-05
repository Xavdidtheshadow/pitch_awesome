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
      tonePlayer.playTone(pitch)
    }
  }
  
  @IBAction func stopPitches() {
    tonePlayer.stopTones()
  }
}
