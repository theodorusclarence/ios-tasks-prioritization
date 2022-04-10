//
//  Task.swift
//  mc1-team-10
//
//  Created by Clarence on 07/04/22.
//

import Foundation

enum TaskStatus: String {
    case unlisted
    case finished
    case one
    case three
    case five
    
    var description: String {
          return "\(self)"
      }
}

enum Difficulty: String {
    case easy, medium, hard
    
    var description: String {
          return "\(self)"
      }
}

struct Task {
    let taskName: String
    let dueDate: String
    let status: TaskStatus
}
