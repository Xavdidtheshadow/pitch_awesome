//
//  TonePlayer.swift
//  PitchAwesome
//
//  Created by David Brownman on 9/23/15.
//  Copyright © 2015 DB. All rights reserved.
//

import Foundation
import AVFoundation

class TonePlayer {
  var generator = TGSineWaveToneGenerator(channels: 2)
  
  func playSound() {
    generator.playForDuration(1)
  }
}