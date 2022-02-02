//
//  CategoryWorker.swift
//  DailyApp
//
//  Created by Oleksandr Zavazhenko on 31/01/2022.
//

import UIKit
import CoreData

protocol CRUD {

  func create()
  func read()
  func update()
  func delete()

}

class CategoryWorker: CRUD {

  let appDelegate = UIApplication.shared.delegate as! AppDelegate

  var categories: [Category] = []
  var categoryTitle: String = ""
  var categoryEmoji: String = ""
  var selectedCategory: Category?

  var numberOfTasks: Int?

  /// Creates a new category and saves to the CoreData
  func create() {

    let managedContext = appDelegate.persistentContainer.viewContext

    let entity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext)!

    let category = NSManagedObject(entity: entity, insertInto: managedContext)

    category.setValue(categoryTitle, forKey: "title")
    category.setValue(categoryEmoji, forKey: "label")

    do {
      try managedContext.save()
      categories.append(category as! Category)
    } catch let error as NSError {
      print("Couldn't save. \(error), \(error.userInfo)")
    }
  }

  /// Fetchs categories from CoreData
  func read() {

    let managedContext = appDelegate.persistentContainer.viewContext

    let fetchRequest = Category.fetchRequest()

    do {
      categories = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print(error)
    }
  }

  func update() {

  }

  /// Deletes a category from CoreData
  func delete() {

    if let categoryToRemove = selectedCategory {

      let managedContext = appDelegate.persistentContainer.viewContext

      managedContext.delete(categoryToRemove)

      do {
        try managedContext.save()
      } catch {
        print(error)
      }
    }
  }
}


