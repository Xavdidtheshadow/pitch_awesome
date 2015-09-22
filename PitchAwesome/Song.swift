//
//  Song.swift
//  PitchAwesome
//
//  Created by David Brownman on 9/21/15.
//  Copyright © 2015 DB. All rights reserved.
//

import Foundation

let pitches = [
  "A": 150,
  "B": 300
]

class Song {
  var notes = [String]()
  var title: String = ""
  
  func play() {
    for pitch in notes {
      playPitch(pitch)
    }
  }
  
  func playPitch(pitch: String) {
    print("Played \(pitches[pitch])")
  }
}