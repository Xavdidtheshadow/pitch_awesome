//
//  AppDelegate.swift
//  PitchAwesome
//
//  Created by David Brownman on 9/21/15.
//  Copyright © 2015 DB. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  let dataModel = DataModel()
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    // shortcut info here: http://www.stringcode.co.uk/add-ios-9s-quick-actions-shortcut-support-in-15-minutes-right-now/
    var launchedFromShortcut = true
    if #available(iOS 9.0, *) {
        if let shortcutItem = launchOptions?["applicationShortcutUserInfoIconKey"] as? UIApplicationShortcutItem {
          launchedFromShortcut = false
          handleShortcutItem(shortcutItem)
        }
    }
    
    let tabBarController = window!.rootViewController as! UITabBarController
    
    if let tabBarViewControllers = tabBarController.viewControllers {
      let navController = tabBarViewControllers[0] as! UINavigationController
      let tableController = navController.viewControllers[0] as! SongsViewController
      tableController.dataModel = dataModel
    }
    
    // I might need to handle this if the app gets deactivated?
    let session = AVAudioSession()
    do {
      try session.setCategory(AVAudioSessionCategoryPlayback)
    } catch {
      print("something else wants it more? \(error)")
    }
    
    return !launchedFromShortcut
  }
  
  @available(iOS 9.0, *)
  func handleShortcutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
    var handled = false
    
    if shortcutItem.type == "com.db.app.addSong" {
      let tabBarController = window!.rootViewController as! UITabBarController
      
      if let tabBarViewControllers = tabBarController.viewControllers {
        let navController = tabBarViewControllers[0] as! UINavigationController
        let tableController = navController.viewControllers[0] as! SongsViewController
        navController.popToRootViewControllerAnimated(false)
        tableController.performSegueWithIdentifier("AddSong", sender: nil)
        handled = true
      }
    }
    
    return handled
  }
  
  @available(iOS 9.0, *)
  func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
    completionHandler(handleShortcutItem(shortcutItem))
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

