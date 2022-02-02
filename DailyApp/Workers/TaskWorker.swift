//
//  TaskWorker.swift
//  DailyApp
//
//  Created by Oleksandr Zavazhenko on 31/01/2022.
//

import Foundation


class TaskWorker: CategoryWorker {

  var newTask: Task?
  var titleTask: String = ""
  var dateTask: Date?
  var selectedTask: Task?

  var tasks: [Task]?

  let userDefaults = UserDefaults.standard

  func createTask(category: Category?) {

    let managedContext = appDelegate.persistentContainer.viewContext

    newTask = Task(context: managedContext)

    if let newTask = newTask {
      newTask.setValue(dateTask, forKey: "date")
      newTask.setValue(titleTask, forKey: "title")
      newTask.setValue(category, forKey: "category")
    }

    do {

      try managedContext.save()
      userDefaults.set(getInfoAboutAllTasks() + 1, forKey: "numberOfAllTasks")

    } catch let error as NSError {
      print("Couldn't save. \(error), \(error.userInfo)")
    }

  }

  func deleteTask() {

    if let selectedTask = selectedTask {

      let managedContext = appDelegate.persistentContainer.viewContext

      managedContext.delete(selectedTask)

      do {
        try managedContext.save()
      } catch {
        print(error)
      }
    }

  }

  func fetchTasks() {

    let managedContext = appDelegate.persistentContainer.viewContext

    let fetchRequest = Task.fetchRequest()

    do {
      tasks = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print(error)
    }

  }

  func completeTask() {

    userDefaults.set(getInfoAboutCompletedTasks() + 1, forKey: "numberOfCompletedTasks")

    deleteTask()

  }

  func getInfoAboutAllTasks() -> Int {

    let numberOfTasks = userDefaults.integer(forKey: "numberOfAllTasks")

    return numberOfTasks

  }

  func getInfoAboutCompletedTasks() -> Int {


    let numberOfTasks = userDefaults.integer(forKey: "numberOfCompletedTasks")

    return numberOfTasks

  }

  func getInfoAboutAllActiveTasks() -> Int {

    fetchTasks()

    if let tasks = tasks {
      return tasks.count
    }
    return 0
  }

  func calculatePercentage() -> Double {

    let completedTasks = Double(getInfoAboutCompletedTasks())
    let allTasks = Double(getInfoAboutAllTasks())

    var percentageOfCompletedTasks = 0.0

    if completedTasks > 0 && allTasks > 0 {
      percentageOfCompletedTasks = floor(completedTasks / allTasks * 100)
    }

    return percentageOfCompletedTasks
  }

}
