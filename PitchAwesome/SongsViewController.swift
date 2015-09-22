//
//  SongsController.swift
//  PitchAwesome
//
//  Created by David Brownman on 9/21/15.
//  Copyright © 2015 DB. All rights reserved.
//

import UIKit

class SongsViewController: UITableViewController {
  var dataModel: DataModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dataModel.generateData()
    tableView.reloadData()
  }
  
  // MARK: Table View
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataModel.songs.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let song = dataModel.songs[indexPath.row]
    
    let cell = tableView.dequeueReusableCellWithIdentifier("Song", forIndexPath: indexPath)
    let titleLabel = cell.viewWithTag(1000) as! UILabel
    let pitchLabel = cell.viewWithTag(1001) as! UILabel
    
    titleLabel.text = song.title
    pitchLabel.text = song.notes.joinWithSeparator(", ")
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let song = dataModel.songs[indexPath.row]
    song.play()
  }
  
}