//
//  TaskList.swift
//  timeboxed tasks
//
//  Created by Daniel Szoke on 21.08.2024.
//

import Foundation


@Observable final class TaskList {
    var tasks: [Task] = []
    
    var taskInProgress: Bool {
        get {
            tasks.contains { $0.inProgress }
        }
    }
    
    init() {}
    
    init(tasks: [Task]) {
        self.tasks = tasks
    }
}
