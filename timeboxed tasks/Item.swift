//
//  Item.swift
//  timeboxed tasks
//
//  Created by Daniel Szoke on 19.08.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
