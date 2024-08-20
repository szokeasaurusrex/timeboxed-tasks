//
//  Task.swift
//  timeboxed tasks
//
//  Created by Daniel Szoke on 19.08.2024.
//

import Foundation
import SwiftData

//@Model
final class Task: Identifiable {
    let id = UUID()
    var name: String
    var timebox: Duration?
    var elapsed: Duration
    var completed: Bool
    
    init(name: String = "", timebox: Duration? = nil, elapsed: Duration = .seconds(0), completed: Bool = false) {
        self.name = name
        self.timebox = timebox
        self.elapsed = elapsed
        self.completed = completed
    }
    
    var remaining: Duration? {
        get {
            return self.timebox.map({ max($0 - self.elapsed, .zero) })
        }
    }
}
