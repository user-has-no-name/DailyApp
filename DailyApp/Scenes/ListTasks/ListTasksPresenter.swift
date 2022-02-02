//
//  ListTasksPresenter.swift
//  DailyApp
//
//  Created by Oleksandr Zavazhenko on 30/01/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListTasksPresentationLogic {
  func presentFetchedTasks(response: ListTasks.FetchTasks.Response)
  func presentUserName(response: UserInfo.FetchUsername.Response)
  func presentGreetings(response: ListTasks.GreetUser.Response)
}

class ListTasksPresenter: ListTasksPresentationLogic {

  weak var viewController: ListTasksDisplayLogic?
  
  // MARK: Do something
  
  func presentFetchedTasks(response: ListTasks.FetchTasks.Response) {

    var displayedCategories: [ListTasks.FetchTasks.ViewModel.DisplayedCategories] = []

    for category in response.categories {

      if let title = category.title,
         let label = category.label,
         let tasks = category.tasks?.allObjects as? [Task] {


        let displayedCategory = ListTasks.FetchTasks.ViewModel.DisplayedCategories(title: label + " " + title,
                                                                                   tasks: tasks)

        displayedCategories.append(displayedCategory)
      }
    }

    let viewModel = ListTasks.FetchTasks.ViewModel(categories: displayedCategories)
    viewController?.displayFetchedTasks(viewModel: viewModel)
  }

  func presentUserName(response: UserInfo.FetchUsername.Response) {

    let viewModel = UserInfo.FetchUsername.ViewModel(username: response.username)

    viewController?.displayUsername(viewModel: viewModel)

  }

  func presentGreetings(response: ListTasks.GreetUser.Response) {

    var greetings = ""
    var activityImage = ""

    switch response.periodOfDay {
    case .morning:
      greetings = "Good Morning,"
      activityImage = "Coffe-Cup"
    case .afternoon:
      greetings = "Good Afternoon,"
      activityImage = "worker"
    case .evening:
      greetings = "Good Evening,"
      activityImage = "worker"
    case .night:
      greetings = "Good Night. What are you doing? You should sleep,"
      activityImage = "worker"
    }

    let viewModel = ListTasks.GreetUser.ViewModel.init(greetings: greetings, activityImage: activityImage)

    viewController?.displayGreetings(viewModel: viewModel)

  }

}