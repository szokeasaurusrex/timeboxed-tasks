//
//  Task.swift
//  timeboxed tasks
//
//  Created by Daniel Szoke on 19.08.2024.
//

import Foundation
import SwiftData

//@Model
@Observable final class Task: Identifiable {
    let id = UUID()
    var name: String
    var timeboxMins: Int?
    var elapsed: Duration
    var completed: Bool = false
    var inProgress: Bool = false
    
    init(name: String = "", timeboxMins: Int? = nil, elapsed: Duration = .seconds(0)) {
        self.name = name
        self.timeboxMins = timeboxMins
        self.elapsed = elapsed
    }
    
    var remaining: Duration? {
        get {
            return self.timeboxMins.map({ max(.seconds($0 * 60) - self.elapsed, .zero) })
        }
    }
}
