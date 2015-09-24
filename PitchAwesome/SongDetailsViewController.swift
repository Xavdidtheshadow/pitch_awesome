//
//  SongDetailsViewController.swift
//  PitchAwesome
//
//  Created by David Brownman on 9/21/15.
//  Copyright © 2015 DB. All rights reserved.
//

import UIKit

protocol SongDetailsViewControllerDelegate: class {
  func songDetailViewControllerDidCancel(controller: SongDetailsViewController)
  func songDetailViewController(controller: SongDetailsViewController, didFinishAddingItem song: Song)
  func songDetailViewController(controller: SongDetailsViewController, didFinishEditingItem song: Song)
}

class SongDetailsViewController: UIViewController {
  @IBOutlet weak var notesLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  
  weak var delegate: SongDetailsViewControllerDelegate?
  
  var songToEdit: Song?
  var notes: [String] = []

  
  // MARK: ViewController Functions
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Looks for single or multiple taps.
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tap)
    
    if let song = songToEdit {
      title = "Edit Song"
      textField.text = song.title
      notes = song.notes
      configureButtons()
      configureNotesLabel()
    }
  }
  
  // MARK: IBActions
  @IBAction func updateNotes(sender: UIButton!) {
    // could also disable all buttons after a 4th is pressed
    // for tag in 100...112; viewWithTag(tag).disabled = true
    if let note = sender.currentTitle {
      if let index = notes.indexOf(note) {
        notes.removeAtIndex(index)
        sender.selected = false
      } else {
        notes.append(note)
        sender.selected = true
//        sender.tintColor = blue
      }
      
      configureNotesLabel()
    }
    // if the user clicks a button, we want to assume they're done typing the song name
    dismissKeyboard()
  }
  
  @IBAction func done() {
    if let song = songToEdit {
      delegate?.songDetailViewController(self, didFinishEditingItem: configureSong(song))
    } else {
      delegate?.songDetailViewController(self, didFinishAddingItem: configureSong(Song()))
    }
  }
  
  @IBAction func cancel() {
    dismissKeyboard()
    delegate?.songDetailViewControllerDidCancel(self)
  }
  
  // MARK: Utils
  func configureNotesLabel() {
    notesLabel.text = notes.joinWithSeparator(", ")
  }
  
  func dismissKeyboard() {
    // Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
  
  // based on an array of notes, checks the appropreate buttons
  func configureButtons() {
    for tag in 100...111 {
      let button = view.viewWithTag(tag) as! UIButton
      if let note = button.currentTitle {
        if let _ = notes.indexOf(note) {
          button.selected = true
        }
      }
    }
  }
  
  // pulls data out ouf UI and model to save new song
  func configureSong(song: Song) -> Song {
    song.title = textField.text!
    song.notes = notes
    return song
  }
}
