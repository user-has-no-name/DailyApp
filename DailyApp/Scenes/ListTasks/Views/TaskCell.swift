//
//  TaskCell.swift
//  DailyApp
//
//  Created by Oleksandr Zavazhenko on 24/01/2022.
//

import UIKit

class TaskCell: UITableViewCell {

  @IBOutlet weak var taskTitle: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func config(with data: Task) {

    taskTitle.text = data.title

  }

}
