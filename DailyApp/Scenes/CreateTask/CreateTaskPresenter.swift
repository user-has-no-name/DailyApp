//
//  CreateTaskPresenter.swift
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

protocol CreateTaskPresentationLogic {

  func presentCategories(response: CreateTask.FetchCategories.Response)

}

class CreateTaskPresenter: CreateTaskPresentationLogic {

  weak var viewController: CreateTaskDisplayLogic?


  func presentCategories(response: CreateTask.FetchCategories.Response) {

    // An array which will contain modified categories
    var categories: [CreateTask.FetchCategories.ViewModel.DisplayedCategories] = []

    for category in response.categories {

      let tasks = category.tasks?.allObjects as? [Task]

      if let tasks = tasks,
         let title = category.title,
         let label = category.label {

        // Connects label and title, so the view controller will only show this info, not modify
        let newTitle = label + title
        let newCategory = CreateTask.FetchCategories.ViewModel.DisplayedCategories(title: newTitle, tasks: tasks)

        categories.append(newCategory)
      }
    }

    let viewModel = CreateTask.FetchCategories.ViewModel(displayedCategories: categories, categories: response.categories)

    // Sends a viewModel with categories to the view controller
    viewController?.displayCategories(viewModel: viewModel)

  }
}
