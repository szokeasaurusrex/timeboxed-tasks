//
//  TaskView.swift
//  timeboxed tasks
//
//  Created by Daniel Szoke on 19.08.2024.
//

import SwiftUI

struct TaskView: View {
    @Binding var task: Task
    @State var timeboxMinutes: Int?

    private func timeFormat() -> some View {
        return HStack(spacing: 5) {
            if let remaining = task.remaining {
                Text("\(remaining.formatted(.units(allowed: [.minutes]))) remaining from")
                    .foregroundStyle(.gray)
            }
            TextField("0", value: $timeboxMinutes, format: .number)
                .textFieldStyle(.plain)
                .multilineTextAlignment(.trailing)
                .frame(width: 24)
                .onChange(of: timeboxMinutes) { _, newValue in
                    print("timebox changed to \(newValue)")
                    task.timebox = newValue.map({ .seconds($0 * 60) })
                }
            Text(" min")
        }
    }

    var body: some View {
        Toggle(isOn: $task.completed) {
            HStack{
                TextField("New task", text: $task.name)
                    .textFieldStyle(.plain)
                Spacer()
                timeFormat()
            }
        }
        .toggleStyle(CircleToggleStyle())
    }
    
    init(task: Binding<Task>) {
        self._task = task
        self._timeboxMinutes = State(initialValue: task.wrappedValue.timebox.flatMap { Int($0.components.seconds) / 60 })
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
    TaskView(task: .constant(Task()))
}
