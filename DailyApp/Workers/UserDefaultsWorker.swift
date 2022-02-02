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

  func fetchUsername(using key: String) -> String {

    return userDefaults.string(forKey: key) ?? "User"

  }

  func changeUsername(newUsername: String, using key: String) {

    userDefaults.set(newUsername, forKey: key)

  }

  func changeDarkMode(using key: String) {

    if userDefaults.bool(forKey: key) {
      userDefaults.set(false, forKey: key)
      appDelegate?.overrideUserInterfaceStyle = .light
      return
    }

    userDefaults.set(true, forKey: key)
    appDelegate?.overrideUserInterfaceStyle = .dark

  }

  func checkDarkMode(using key: String) -> Bool {

    return userDefaults.bool(forKey: key)

  }

}
