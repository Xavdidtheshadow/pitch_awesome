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
  // C4 to B4, taken from Wikipedia
  let pitches = [
    "C": TGSineWaveToneGenerator(frequency: 261.63, amplitude: 0.25),
    "C#": TGSineWaveToneGenerator(frequency: 277.18, amplitude: 0.25),
    "D": TGSineWaveToneGenerator(frequency: 293.66, amplitude: 0.25),
    "D#": TGSineWaveToneGenerator(frequency: 311.13, amplitude: 0.25),
    "E": TGSineWaveToneGenerator(frequency: 329.63, amplitude: 0.25),
    "F": TGSineWaveToneGenerator(frequency: 349.23, amplitude: 0.25),
    "F#": TGSineWaveToneGenerator(frequency: 369.99, amplitude: 0.25),
    "G": TGSineWaveToneGenerator(frequency: 392.00, amplitude: 0.25),
    "G#": TGSineWaveToneGenerator(frequency: 415.30, amplitude: 0.25),
    "A": TGSineWaveToneGenerator(frequency: 440.00, amplitude: 0.25),
    "B♭": TGSineWaveToneGenerator(frequency: 466.16, amplitude: 0.25),
    "B": TGSineWaveToneGenerator(frequency: 493.88, amplitude: 0.25)
  ]
  
  func playTones(song: Song) {
    for note in song.notes {
      if let generator = pitches[note] {
        generator.playForDuration(0.75)
      }
    }
  }
}