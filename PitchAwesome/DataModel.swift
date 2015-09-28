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
  
  init() {
    loadData()
  }
  
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
  
  // MARK: Data Retrieval
  func saveData() {
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
    archiver.encodeObject(songs, forKey: "Songs")
    archiver.finishEncoding()
    data.writeToFile(dataFilePath(), atomically: true)
  }
  
  func loadData() {
    let path = dataFilePath()
    if NSFileManager.defaultManager().fileExistsAtPath(path) {
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        songs = unarchiver.decodeObjectForKey("Songs") as! [Song]
        unarchiver.finishDecoding()
      }
    }
  }
  
  // MARK: Util
  func documentsDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    return paths[0]
  }
  
  func dataFilePath() -> String {
    return (documentsDirectory() as NSString).stringByAppendingPathComponent("PitchAwesome.plist")
  }
}