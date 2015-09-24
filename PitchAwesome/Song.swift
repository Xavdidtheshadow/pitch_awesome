//
//  Song.swift
//  PitchAwesome
//
//  Created by David Brownman on 9/21/15.
//  Copyright © 2015 DB. All rights reserved.
//

import Foundation

// C4 to B4, taken from Wikipedia
let pitches = [
  "C": 261.63,
  "C#": 277.18,
  "D": 293.66,
  "D#": 311.13,
  "E": 329.63,
  "F": 349.23,
  "F#": 369.99,
  "G": 392.00,
  "G#": 415.30,
  "A": 440.00,
  "B♭": 466.16,
  "B": 493.88,
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