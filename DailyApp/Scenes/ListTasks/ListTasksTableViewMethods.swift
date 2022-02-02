//
//  ListTasksTableViewMethods.swift
//  DailyApp
//
//  Created by Oleksandr Zavazhenko on 01/02/2022.
//

import UIKit

// MARK: TABLEVIEW DATA SOURCE AND DELEGATE METHODS
extension ListTasksViewController {

  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return categories.count
  }

  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {

    return categories[section].tasks.count

  }

  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell",
                                             for: indexPath) as! TaskCell

    let tasks = categories[indexPath.section].tasks

    cell.taskTitle.text = tasks[indexPath.row].title

    return cell
  }

  override func tableView(_ tableView: UITableView,
                          titleForHeaderInSection section: Int) -> String? {

    return categories[section].title

  }

  override func tableView(_ tableView: UITableView,
                          contextMenuConfigurationForRowAt indexPath: IndexPath,
                          point: CGPoint) -> UIContextMenuConfiguration? {


    let configuration = UIContextMenuConfiguration(identifier: nil,
                                                   previewProvider: nil) { actions -> UIMenu? in

      let complete = UIAction(title: "Finish task",
                              image: UIImage(systemName: "checkmark.circle"),
                              identifier: nil) { action in


        let tasks = self.categories[indexPath.section].tasks

        self.completeTask(selectedTask: tasks[indexPath.row], at: indexPath)

        self.tableView.reloadData()
      }

      let delete = UIAction(title: "Delete",
                            image: UIImage(systemName: "trash.fill"),
                            identifier: nil) { action in

        DispatchQueue.main.async {
          self.showDeleteWarning(for: indexPath)
        }

      }

      return UIMenu(title: "Menu",
                    image: nil,
                    identifier: nil,
                    children:[complete, delete])
    }
    return configuration
  }

  override func tableView(_ tableView: UITableView,
                          canMoveRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
  }

  override func tableView(_ tableView: UITableView,
                          leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

    let completeAction = UIContextualAction(style: .normal, title: "Complete Task") { action, view, completionHandler in

      let tasks = self.categories[indexPath.section].tasks

      self.completeTask(selectedTask: tasks[indexPath.row], at: indexPath)

      self.fetchTasks()

      self.tableView.reloadData()
    }
    completeAction.image = UIImage(systemName: "checkmark.circle")
    completeAction.backgroundColor = .green

    return UISwipeActionsConfiguration(actions: [completeAction])

  }

  override func tableView(_ tableView: UITableView,
                          trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {


    let deleteAction = UIContextualAction(style: .destructive,
                                          title: "Delete Task") { action, view, completionHandler in

      DispatchQueue.main.async {
        self.showDeleteWarning(for: indexPath)
      }
    }

    deleteAction.image = UIImage(systemName: "trash.fill")

    return UISwipeActionsConfiguration(actions: [deleteAction])

  }

  func showDeleteWarning(for indexPath: IndexPath) {
      //Create the alert controller and actions
      let alert = UIAlertController(title: "Warning",
                                    message: "Are you sure, you want to remove this task?",
                                    preferredStyle: .alert)

      let cancelAction = UIAlertAction(title: "Cancel",
                                       style: .cancel, handler: nil)

      let deleteAction = UIAlertAction(title: "Delete",
                                       style: .destructive) { _ in

          DispatchQueue.main.async {
            let taskToDelete = self.categories[indexPath.section].tasks[indexPath.row]

            self.deleteRow(taskToDelete: taskToDelete, at: indexPath)

            self.fetchTasks()
            
            self.tableView.reloadData()

          }
      }

      //Add the actions to the alert controller
      alert.addAction(cancelAction)
      alert.addAction(deleteAction)

      //Present the alert controller
      present(alert, animated: true, completion: nil)
  }

  func deleteRow(taskToDelete: Task,
                 at indexPath: IndexPath) {

    let request = ListTasks.DeleteTask.Request(selectedTask: taskToDelete)

    interactor?.deleteTask(request: request)

  }

}
