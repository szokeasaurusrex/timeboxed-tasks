//
//  ContentView.swift
//  timeboxed tasks
//
//  Created by Daniel Szoke on 19.08.2024.
//

import SwiftUI
import SwiftData
import UserNotifications

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var taskList: TaskList = TaskList()

    var body: some View {
        TasksView(title: "hi", taskList: $taskList)//.task({ await self.requestNotifications() })
    }
    
//    private func requestNotifications() async {
//        do {
//            try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
//        } catch {
//            print("denied")
//        }
//        
//        let completeAction = UNNotificationAction(identifier: "complete", title: "Mark Completed", options: [])
//        let extendAction = UNNotificationAction(identifier: "extend", title: "Extend Timebox", options: [])
//        
//        let category = UNNotificationCategory(identifier: "taskComplete", actions: [completeAction, extendAction], intentIdentifiers: [])
//        
//        UNUserNotificationCenter.current().setNotificationCategories([category])
//        
//        let content = UNMutableNotificationContent()
//        content.title = "Time's Up"
//        content.body = "The \"Write Notion Doc\" timebox has expired."
//        content.sound = .default
//        content.categoryIdentifier = "taskComplete"
//        
//        
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
//        do {
//            try await UNUserNotificationCenter.current().add(request)
//        } catch {}
//    }
}

#Preview {
    ContentView()
}
