//
//  ProfileModels.swift
//  DailyApp
//
//  Created by Oleksandr Zavazhenko on 01/02/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum UserInfo {

  enum FetchStats {

    struct Request {

    }

    struct Response {

      var numberOfAllTasks: Int
      var numberOfCompletedTasks: Int
      var numberOfActiveTasks: Int
      var percentage: Double
      
    }

    struct ViewModel {

      struct Stats {

        var numberOfAllTasks: String
        var numberOfCompletedTasks: String
        var numberOfActiveTasks: String
        var percentage: Double

      }

      var stats: Stats

    }

  }

  enum FetchUserPick {

    struct Request {
      var fileName: String
    }

    struct Response {
      var imageName: String
    }

    struct ViewModel {
      var image: UIImage
    }

  }

  enum ChangeUsername {
    struct Request {
      var newUserName: String
      var userDefaultsKey: String
    }

    struct Response {

    }

    struct ViewModel {

    }
  }

  enum FetchUsername {
    struct Request {
      var userDefaultsKey: String
    }

    struct Response {

      var username: String

    }

    struct ViewModel {

      var username: String

    }
  }

  enum CheckDarkMode {
    struct Request {
      var userDefaultsKey: String
    }

    struct Response {
      var isOn: Bool
    }

    struct ViewModel {
      var isOn: Bool
    }
  }

  enum ChangeDarkMode {

    struct Request {
      var userDefaultsKey: String
    }

    struct Response {

    }

    struct ViewModel {

    }

  }

  enum ChangeUserPick {

    struct Request {
      var image: UIImage
    }

    struct Response {

    }

    struct ViewModel {

    }

  }

}

enum Profile
{
  // MARK: Use cases
  
  enum Something
  {
    struct Request
    {
    }
    struct Response
    {
    }
    struct ViewModel
    {
    }
  }
}
