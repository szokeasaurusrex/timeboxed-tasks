//
//  TaskView.swift
//  timeboxed tasks
//
//  Created by Daniel Szoke on 19.08.2024.
//

import SwiftUI

struct TaskView: View {
    @Binding var task: Task
    let taskInProgress: Bool
    var countdownTimer: Timer?


    private func timeFormat() -> some View {
        return HStack(spacing: 5) {
            if task.remaining != nil && task.elapsed > .zero {
                Text("\(task.remaining!.formatted(.units(allowed: [.minutes, .seconds], maximumUnitCount: 1, fractionalPart: .hide(rounded: .towardZero)))) remaining from ")
            }
            TextField("0", value: $task.timeboxMins, format: .number)
                .onChange(of: task.timeboxMins) { oldValue, newValue in
                    if oldValue != newValue {
                        task.elapsed = .zero
                    }
                }
                .textFieldStyle(.plain)
                .multilineTextAlignment(.trailing)
                .frame(width: 30, alignment: .trailing)
            Text(" min")
        }
    }

    var body: some View {
        HStack {
            Toggle(isOn: $task.completed) {}
                .toggleStyle(CircleToggleStyle())
            TextField("New task", text: $task.name)
                .textFieldStyle(.plain)
            Spacer()
            timeFormat()
            TaskTimerView(task: $task, taskInProgress: taskInProgress)
        }
    }
}

struct CircleToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "circle.inset.filled" : "circle")
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

#Preview {
    TaskView(task: .constant(Task()), taskInProgress: false)
}
