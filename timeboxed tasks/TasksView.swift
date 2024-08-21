//
//  TasksView.swift
//  timeboxed tasks
//
//  Created by Daniel Szoke on 19.08.2024.
//

import SwiftUI

struct TasksView: View {
    let title: String
    @Binding var taskList: TaskList

    var body: some View {
        List($taskList.tasks, editActions: .all) { $task in
            TaskView(task: $task, taskInProgress: taskList.taskInProgress).deleteDisabled(task.inProgress)
        }
        .toolbar {
            Button {
                taskList.tasks.append(Task())
            } label: {
                Label("New Task", systemImage: "plus")
            }
        }
    }
}

#Preview {
    TasksView(title: "Hello", taskList: .constant(TaskList(tasks: [Task(name: "Hello, world!", timeboxMins: 120, elapsed: .seconds(60)), Task(name: "other", timeboxMins: 120)])))
}
