//
//  DataModel.swift
//  PitchAwesome
//
//  Created by David Brownman on 9/21/15.
//  Copyright © 2015 DB. All rights reserved.
//

import Foundation

class DataModel {
  var songs = [Song]()
  
  func generateData() {
    let s = Song()
    s.notes.append("G#")
    s.title = "Valerie"
    songs.append(s)
    
    let s2 = Song()
    s2.notes.append("B♭")
    s2.title = "Let Loose the Horses"
    songs.append(s2)
  }
}