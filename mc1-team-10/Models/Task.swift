//
//  Task.swift
//  mc1-team-10
//
//  Created by Clarence on 07/04/22.
//

import Foundation

enum TaskStatus {
    case unlisted
    case finished
    case one
    case three
    case five
}

struct Task {
    let taskName: String
    let dueDate: String
    let status: TaskStatus
}
