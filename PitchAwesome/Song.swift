//
//  Song.swift
//  PitchAwesome
//
//  Created by David Brownman on 9/21/15.
//  Copyright © 2015 DB. All rights reserved.
//

import Foundation

class Song: NSObject, NSCoding {
  var title: String = ""
  var notes = [String]()

  // do I need this?
  // var key: String = ""
  
  override init() {
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    title = aDecoder.decodeObjectForKey("Title") as! String
    notes = aDecoder.decodeObjectForKey("Notes") as! [String]
    super.init()
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(title, forKey: "Title")
    aCoder.encodeObject(notes, forKey: "Notes")
  }
}
