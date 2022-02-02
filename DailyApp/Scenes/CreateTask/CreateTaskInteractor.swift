//
//  CreateTaskInteractor.swift
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

protocol CreateTaskBusinessLogic {

  func createTask(request: CreateTask.CreateTask.Request)
  func fetchCategories(request: CreateTask.FetchCategories.Request)
  func createCategory(request: CreateTask.CreateCategory.Request)
  func deleteCategory(request: CreateTask.DeleteCategory.Request)

}

protocol CreateTaskDataStore {
  //var name: String { get set }
}

class CreateTaskInteractor: CreateTaskBusinessLogic,
                            CreateTaskDataStore {

  var presenter: CreateTaskPresentationLogic?

  var categoryWorker: CategoryWorker = CategoryWorker()
  var taskWorker: TaskWorker = TaskWorker()
  

  /// Fetchs data of a task from request
  /// Sends that info to the worker which will create a task and save it to the CoreData
  /// This method doesn't communicate with a presenter
  func createTask(request: CreateTask.CreateTask.Request) {

    let category = request.taskFormFields.category

    taskWorker.titleTask = request.taskFormFields.title
    taskWorker.dateTask = request.taskFormFields.date

    taskWorker.createTask(category: category)

  }

  /// Fetchs data of a category from request
  /// Sends that info to the worker which will create a category and save it to the CoreData
  /// This method doesn't communicate with a presenter
  func createCategory(request: CreateTask.CreateCategory.Request) {

    categoryWorker.categoryEmoji = request.categoryFromFields.label
    categoryWorker.categoryTitle = request.categoryFromFields.title

    categoryWorker.create()
  }

  /// Fetch categories from CoreData using a CategoryWorker
  /// Creates a response using fetched data and sends it to the presenter
  func fetchCategories(request: CreateTask.FetchCategories.Request) {

    categoryWorker.read()

    let categories = categoryWorker.categories
    let response = CreateTask.FetchCategories.Response(categories: categories)

    presenter?.presentCategories(response: response)

  }

  /// Deletes a category from a request 
  func deleteCategory(request: CreateTask.DeleteCategory.Request) {

    categoryWorker.selectedCategory = request.categoryToDelete
    categoryWorker.delete()
    
  }
}
