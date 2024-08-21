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

    private func timeFormat() -> some View {
        return HStack(spacing: 5) {
            if let remaining = task.remaining {
                Text("\(remaining.formatted(.units(allowed: [.minutes, .seconds], maximumUnitCount: 1))) remaining from ")
            }
            TextField("0", value: $task.timeboxMins, format: .number)
                .textFieldStyle(.plain)
                .multilineTextAlignment(.trailing)
                .frame(width: 30, alignment: .trailing)
            Text(" min")
        }
    }
    
    private func startStopToggle() -> some View {
        let disabled = task.timeboxMins == nil || task.name == "" || (taskInProgress && !task.inProgress)

        return Toggle(isOn: $task.inProgress) {}
            .toggleStyle(StartStopToggleStyle(isDisabled: disabled))
            .disabled(disabled)
    }

    var body: some View {
        HStack {
            Toggle(isOn: $task.completed) {}
                .toggleStyle(CircleToggleStyle())
            TextField("New task", text: $task.name)
                .textFieldStyle(.plain)
            Spacer()
            timeFormat()
            startStopToggle()
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



struct StartStopToggleStyle: ToggleStyle {
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
    TaskView(task: .constant(Task()), taskInProgress: false)
}
