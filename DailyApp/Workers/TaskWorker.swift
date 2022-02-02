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

  /// Creates a task and saves it to CoreData
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

      // Whenever a task is saved to CoreData it increments a number of all tasks by one in UserDefaults
      userDefaults.set(getInfoAboutAllTasks() + 1, forKey: "numberOfAllTasks")

    } catch let error as NSError {
      print("Couldn't save. \(error), \(error.userInfo)")
    }
  }

  /// Deletes a task from CoreData
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

  /// Fetchs tasks from CoreData
  func fetchTasks() {

    let managedContext = appDelegate.persistentContainer.viewContext

    let fetchRequest = Task.fetchRequest()

    do {
      tasks = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print(error)
    }
  }

  /// "Completes a task" by deleting a task from CoreData
  func completeTask() {

    // Gets number of all completed tasks and add 1 to that number
    // Next - saves to UserDefaults
    userDefaults.set(getInfoAboutCompletedTasks() + 1, forKey: "numberOfCompletedTasks")

    deleteTask()
  }

  /// Method that gets info about number of all tasks from UserDefaults
  func getInfoAboutAllTasks() -> Int {

    let numberOfTasks = userDefaults.integer(forKey: "numberOfAllTasks")

    return numberOfTasks
  }

  /// Method that gets info about number of all completed tasks from UserDefaults
  func getInfoAboutCompletedTasks() -> Int {

    let numberOfTasks = userDefaults.integer(forKey: "numberOfCompletedTasks")

    return numberOfTasks
  }

  /// Method that gets info about number of all active tasks from UserDefaults
  func getInfoAboutAllActiveTasks() -> Int {

    fetchTasks()

    if let tasks = tasks {
      return tasks.count
    }
    return 0
  }

  /// Method that calculates rate of completed tasks
  /// Returns a double ( completedTasks / allTasks)
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
