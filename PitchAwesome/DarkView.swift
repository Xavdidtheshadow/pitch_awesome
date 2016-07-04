//
//  DarkBackground.swift
//  PitchAwesome
//
//  Created by David Brownman on 11/8/15.
//  Copyright © 2015 DB. All rights reserved.
//
//  Adapted from: http://stackoverflow.com/a/33601506/1825390

import UIKit

protocol DarkViewDelegate: class {
  func tappedDark(view: DarkView)
}

class DarkView : UIView, UIGestureRecognizerDelegate {
  
  var delegate : DarkViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(DarkView.tapped))
    tap.delegate = self
    self.addGestureRecognizer(tap)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func tapped() {
    if let del = self.delegate {
      del.tappedDark(self)
    }
  }
}
