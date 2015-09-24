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
  let tonePlayer = TonePlayer()
  
  override func viewDidLoad() {
    dataModel.generateData()
    super.viewDidLoad()
  }
  
  // MARK: Table View
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataModel.songs.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Song", forIndexPath: indexPath)
    let song = dataModel.songs[indexPath.row]
    
    configureTextForCell(cell, song: song)
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let song = dataModel.songs[indexPath.row]
    song.play()
//    performSegueWithIdentifier("EditSong", sender: song)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    dataModel.songs.removeAtIndex(indexPath.row)
    
    let paths = [indexPath]
    tableView.deleteRowsAtIndexPaths(paths, withRowAnimation: .Automatic)
  }
  
  // MARK: View Stuff
  
  func configureTextForCell(cell: UITableViewCell, song: Song) {
    // could also just subclass UITableViewCell instead of grabbing labels as identifiers a la P3
    let titleLabel = cell.viewWithTag(1000) as! UILabel
    let pitchLabel = cell.viewWithTag(1001) as! UILabel
    
    titleLabel.text = song.title
    pitchLabel.text = song.notes.joinWithSeparator(", ")
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let navigationController = segue.destinationViewController as! UINavigationController
    let controller = navigationController.topViewController as! SongDetailsViewController
    controller.delegate = self
    
    if segue.identifier == "EditSong" {
      if let indexPath = tableView.indexPathForCell( sender as! UITableViewCell) {
        controller.songToEdit = dataModel.songs[indexPath.row]
      }
    }
  }
}

extension SongsViewController: SongDetailsViewControllerDelegate {
  func songDetailViewControllerDidCancel(controller: SongDetailsViewController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func songDetailViewController(controller: SongDetailsViewController, didFinishAddingItem song: Song) {
    let newRowIndex = dataModel.songs.count
    
    dataModel.songs.append(song)
    
    let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
    let indexPaths = [indexPath]
    tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  func songDetailViewController(controller: SongDetailsViewController, didFinishEditingItem song: Song) {
    tableView.reloadData()
    dismissViewControllerAnimated(true, completion: nil)
  }
}


