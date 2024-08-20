//
//  TasksView.swift
//  timeboxed tasks
//
//  Created by Daniel Szoke on 19.08.2024.
//

import SwiftUI

struct TasksView: View {
    let title: String
    @Binding var tasks: [Task]

    var body: some View {
        List($tasks) { $task in
            TaskView(task: $task)
        }
        .toolbar {
            Button {
                tasks.append(Task())
            } label: {
                Label("New Task", systemImage: "plus")
            }
        }
    }
}

#Preview {
    TasksView(title: "Hello", tasks: .constant([Task(name: "Hello, world!", timebox: .seconds(120), elapsed: .seconds(60)), Task(name: "other", timebox: .seconds(180))]))
}
