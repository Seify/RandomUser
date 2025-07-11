//
//  Item.swift
//  RandomUser
//
//  Created by Roman Smirnov on 11.07.2025.
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
