//
//  SongDetailsViewController.swift
//  PitchAwesome
//
//  Created by David Brownman on 9/21/15.
//  Copyright © 2015 DB. All rights reserved.
//

import UIKit

class SongDetailsViewController: UIViewController {
  @IBOutlet weak var notesLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  
  var notes: [String] = []
//  var dataModel: DataModel
  
  // MARK: ViewController Functions
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    textField.becomeFirstResponder()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Looks for single or multiple taps.
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
    view.addGestureRecognizer(tap)
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
      }
      
      configureNotesLabel()
    }
  }
  
  @IBAction func done() {
//    save it
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func cancel() {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: Utils
  func configureNotesLabel() {
    notesLabel.text = notes.joinWithSeparator(", ")
  }
  
  func DismissKeyboard(){
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
}
