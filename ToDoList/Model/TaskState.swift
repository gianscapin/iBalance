//
//  TaskState.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 05/09/2023.
//

import Foundation

enum TaskState: String {
    case TODO = "TODO"
    case DOING = "DOING"
    case DONE = "DONE"
    
    var stringValue: String {
        return self.rawValue
    }
}
