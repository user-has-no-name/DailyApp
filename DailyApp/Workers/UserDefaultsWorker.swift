//
//  UserDefaultsWorker.swift
//  DailyApp
//
//  Created by Oleksandr Zavazhenko on 01/02/2022.
//

import Foundation
import UIKit


class UserDefaultsWorker {

  private let userDefaults = UserDefaults.standard
  private weak var appDelegate = UIApplication.shared.keyWindow

  /// Method that returns a username from UserDefaults
  func fetchUsername(using key: String) -> String {

    return userDefaults.string(forKey: key) ?? "User"

  }

  /// Method that changes a username in UserDefaults
  func changeUsername(newUsername: String, using key: String) {

    userDefaults.set(newUsername, forKey: key)

  }

  /// Method that changes a status of dark mode
  func changeDarkMode(using key: String) {

    // Checks whether dark mode status in UserDefaults were on or off
    if userDefaults.bool(forKey: key) {

      userDefaults.set(false, forKey: key)
      appDelegate?.overrideUserInterfaceStyle = .light
      return
    }

    userDefaults.set(true, forKey: key)
    appDelegate?.overrideUserInterfaceStyle = .dark

  }

  /// Checks dark mode status
  /// Returns true if dark mode is on otherwise returns false
  func checkDarkMode(using key: String) -> Bool {

    return userDefaults.bool(forKey: key)

  }

}
