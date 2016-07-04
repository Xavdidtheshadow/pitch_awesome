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
    let notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "c", "c#", "d", "d#", "e", "f", "f#", "g", "g#", "a", "a#", "b"]
    for pitch in notes {
      pitches[pitch] = buildAudioPlayer(pitchForTitle(pitch))
    }
  }
  
  func playTone(tone: String) {
    if let player = pitches[tone] {
      // infinite loops!
      player.numberOfLoops = -1
      player.play()
    }
  }
  
  func stopTone(tone: String) {
    if let player = pitches[tone] {
      player.stop()
      player.prepareToPlay()
    }
  }
  
  func stopTones() {
    for pitch in pitches.keys {
      pitches[pitch]?.numberOfLoops = 1
//      pitches[pitch]?.currentTime = 0
      pitches[pitch]?.stop()
      pitches[pitch]?.prepareToPlay()
    }
  }
  
  func playTones(song: Song) {
    // tap a cell again to stop!
    if !queue.isEmpty {
      queue.first?.stop()
      queue.first?.currentTime = 0
      queue.first?.prepareToPlay()
      queue.removeAll()
    } else {
      for note in song.notes {
        if let player = pitches[note] {
          queue.append(player)
        } else {
          print("*** No player for \(note)!")
        }
      }
      queue.first?.play()
    }
  }
  
  // MARK: Utils
  func buildAudioPlayer(title: String) -> AVAudioPlayer {
    guard let url = NSBundle.mainBundle().pathForResource(title, ofType: "aiff", inDirectory: "tones") else {
      return AVAudioPlayer()
    }
    let sound = NSURL(fileURLWithPath: url)
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
  
  // takes a string (eg: "C#") and turns it into a file name (eg: "highCSharp")
  func pitchForTitle(title: String) -> String {
    var fname = [String]()
    let ord = title.asciiValueAt(pos: 0)
    // this can only be the letters A-G, either capitalization
    if ord >= 65 && ord <= 90 {
      fname.append("high")
    } else {
      fname.append("low")
    }
    fname.append(title.uppercaseString)
    return fname.joinWithSeparator("").stringByReplacingOccurrencesOfString("#", withString: "Sharp")
  }
  
  // MARK: Delegate methods
  func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
    // burn through the audio queue
//    if player.numberOfLoops > 0 {
      queue.removeFirst()
      queue.first?.play()
//    }
  }
}

// source: http://stackoverflow.com/a/29835826/1825390
extension String {
  func asciiValueAt(pos pos: UInt32) -> UInt32 {
    guard characters.count > 0 && Int(pos) < characters.count else  { return 0 }
    return Array(characters)[Int(pos)].unicodeScalarsValue
  }
}
extension Character {
  var unicodeScalarsValue: UInt32 {
    return String(self).unicodeScalars.first!.value
  }
}
