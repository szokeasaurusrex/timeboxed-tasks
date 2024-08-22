//
//  TaskTimerView.swift
//  timeboxed tasks
//
//  Created by Daniel Szoke on 21.08.2024.
//

import SwiftUI

struct TaskTimerView: View {
    @Binding var task: Task
    let taskInProgress: Bool
    let disabled: Bool
    let timer: Timer?
    var lastUpdate: ContinuousClock.Instant? = nil
    
    var body: some View {
        Toggle(isOn: $task.inProgress) {}
            .toggleStyle(StartStopToggleStyle(isDisabled: disabled))
            .disabled(disabled)
            .onChange(of: task.inProgress) {
                if let timer {
                    timer.invalidate()
                } else {
                    // Enabling timer
                    task.updateElapsedTime()
                }
            }
    }
    
    init(task: Binding<Task>, taskInProgress: Bool) {
        self._task = task
        let task = task.wrappedValue
        self.taskInProgress = taskInProgress
        self.disabled = task.timeboxMins == nil || task.name == "" || (taskInProgress && !task.inProgress)
        if task.inProgress {
            timer = Timer(timeInterval: 1.0, repeats: false) { timer in
                task.updateElapsedTime()
            }
            RunLoop.current.add(timer!, forMode: .common)
        } else {
            timer = nil
        }
    }
}

private struct StartStopToggleStyle: ToggleStyle {
    let isDisabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Image(systemName: configuration.isOn ? "pause.circle.fill" : "play.circle")
                .font(.title2)
                .foregroundStyle(self.isDisabled ? .gray : Color.accentColor)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TaskTimerView(task: .constant(Task()), taskInProgress: false)
}
