//
//  ContentView.swift
//  timeboxed tasks
//
//  Created by Daniel Szoke on 19.08.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var tasks: [Task] = [Task(timebox: .seconds(180))]

    var body: some View {
        TasksView(title: "hi", tasks: $tasks)
    }
}

#Preview {
    ContentView()
}
