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
    private var timebox: Duration?
    var elapsed: Duration
    var completed: Bool = false
    var lastElapsedUpdate: ContinuousClock.Instant?
    
    init(name: String = "", timeboxMins: Int? = nil, elapsed: Duration = .seconds(0)) {
        self.name = name
        self.elapsed = elapsed
        self.timeboxMins = timeboxMins
    }
    
    var remaining: Duration? {
        get {
            return self.timeboxMins.map({ max(.seconds($0 * 60) - self.elapsed, .zero) })
        }
    }
    
    var inProgress: Bool {
        get {
            return lastElapsedUpdate != nil
        }
        set (_inProgress) {
            if _inProgress {
                lastElapsedUpdate = ContinuousClock.now
            } else if let lastElapsedUpdate {
                elapsed += ContinuousClock.now - lastElapsedUpdate
                self.lastElapsedUpdate = nil
            }
        }
    }
    
    var timeboxMins: Int? {
        get {
            timebox.map { Int($0.components.seconds) / 60 }
        } set(_timeboxMins) {
            timebox = _timeboxMins.map { .seconds($0 * 60) }
        }
    }
    
    func updateElapsedTime() {
        if let lastElapsedUpdate {
            let currentUpdateInstant = ContinuousClock.now
            elapsed += currentUpdateInstant - lastElapsedUpdate
            
            if timebox == nil || elapsed >= timebox! {
                self.lastElapsedUpdate = nil
            } else {
                self.lastElapsedUpdate = currentUpdateInstant
            }
        }
    }
}
