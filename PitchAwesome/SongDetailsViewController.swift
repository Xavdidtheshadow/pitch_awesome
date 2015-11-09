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
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    if let song = songToEdit {
      title = "Edit Song"
      textField.text = song.title
      notes = song.notes
      configureButtons()
      configureNotesLabel()
    } else {
      // probably only renaming a new song
      textField.becomeFirstResponder()
    }
  }
  
  // MARK: IBActions
  @IBAction func updateNotes(sender: UIButton!) {
    if let note = sender.currentTitle {
      if let index = notes.indexOf(note) {
        notes.removeAtIndex(index)
        
        sender.backgroundColor = UIColor.lightGrayColor()
        sender.tintColor = UIColor.blackColor()
      } else {
        notes.append(note)
        
        sender.backgroundColor = UIColor.blueColor()
        sender.tintColor = UIColor.yellowColor()
      }
      
      configureNotesLabel()
    }
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
  
  func focusUserOn(textfield: UITextField) {
    if let superV = textfield.superview {
      let darkArea = DarkView(frame: superV.bounds)
      darkArea.delegate = self
      
      // add DarkView (everything is dark now)
      superV.addSubview(darkArea)
      
      // bring the textview back to the front.
      superV.bringSubviewToFront(textfield)
    }
  }
}

extension SongDetailsViewController: DarkViewDelegate, UITextViewDelegate {
  // delegate function of a textfield
  func textFieldDidBeginEditing(sender: UITextField) {
    focusUserOn(sender) // darken everything else
  }
  
  // delegate function of DarkView undarken everything
  func tappedDark(view: DarkView) {
    
    guard let superV = view.superview else {
      return
    }
    
    if let textField = superV.subviews.last as? UITextField {
      textField.resignFirstResponder() // also stop editing
    }
    
    view.removeFromSuperview()
  }
}
