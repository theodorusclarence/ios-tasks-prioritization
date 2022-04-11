//
//  TaskItem+CoreDataProperties.swift
//  mc1-team-10
//
//  Created by Clarence on 10/04/22.
//
//

import Foundation
import CoreData



extension TaskItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "TaskItem")
    }
    

    @NSManaged public var taskName: String?
    @NSManaged public var dueDate: Date?
    @NSManaged public var isFinished: Bool
    @NSManaged public var status: String?
    var taskStatus: TaskStatus {
            set {
                status = newValue.rawValue
            }
            get {
                TaskStatus(rawValue: status ?? "unlisted") ?? .unlisted
            }
    }
    
    @NSManaged public var difficulty: String?
    var taskDifficulty: Difficulty {
        set {
            difficulty = newValue.rawValue
        }
        get {
            Difficulty(rawValue: difficulty ?? "easy") ?? .easy
        }
}
    
    

}

extension TaskItem : Identifiable {

}
