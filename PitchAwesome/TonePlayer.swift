//
//  TonePlayer.swift
//  PitchAwesome
//
//  Created by David Brownman on 9/23/15.
//  Copyright © 2015 DB. All rights reserved.
//

import Foundation
import AVFoundation

class TonePlayer: NSObject, AVAudioPlayerDelegate {
  var pitches = [String: AVAudioPlayer]()
  var queue = [AVAudioPlayer]()
  
  override init() {
    super.init()
    // setup audio players
    for pitch in ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "B♭", "B"] {
      pitches[pitch] = buildAudioPlayer(pitchForTitle(pitch))
    }
  }
  
  func playTones(song: Song) {
    for note in song.notes {
      if let player = pitches[note] {
        queue.append(player)
      } else {
        print("*** No player for \(note)!")
      }
    }
    queue.first?.play()
  }
  
  // MARK: Utils
  func buildAudioPlayer(title: String) -> AVAudioPlayer {
    let sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(title, ofType: "mp3", inDirectory: "tones")!)
    do {
      let audioPlayer = try AVAudioPlayer(contentsOfURL: sound)
      audioPlayer.prepareToPlay()
      audioPlayer.delegate = self
      return audioPlayer
    } catch {
      print(error)
      return AVAudioPlayer()
    }
  }
  
  func pitchForTitle(title: String) -> String {
    // sometimes note titles don't match filenames
    switch title {
      case "B♭":
        return "BFlat"
      case "C#":
        return "CSharp"
      case "D#":
        return "DSharp"
      case "F#":
        return "FSharp"
      case "G#":
        return "GSharp"
      default:
        return title
    }
  }
  
  // MARK: Delegate methods
  func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
    // burn through the audio queue
    queue.removeFirst()
    queue.first?.play()
  }
}

