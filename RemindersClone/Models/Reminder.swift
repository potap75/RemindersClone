//
//  Reminder.swift
//  RemindersClone
//
//  Created by Roman Potapov on 7/31/24.
//

import Foundation
import SwiftData

@Model
class Reminder {
    
    var title: String
    var notes: String?
    var isComplete: Bool
    var reminderDate: Date?
    var reminderTime: Date?
    
    var list: MyList?
    
    init(title: String, notes: String? = nil, isComplete: Bool, reminderDate: Date? = nil, reminderTime: Date? = nil, list: MyList? = nil) {
        self.title = title
        self.notes = notes
        self.isComplete = isComplete
        self.reminderDate = reminderDate
        self.reminderTime = reminderTime
        self.list = list
    }
}
