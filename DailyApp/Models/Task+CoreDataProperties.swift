//
//  Task+CoreDataProperties.swift
//  DailyApp
//
//  Created by Oleksandr Zavazhenko on 24/01/2022.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var category: Category?

}

extension Task : Identifiable {

}
