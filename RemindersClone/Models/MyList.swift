//
//  MyList.swift
//  RemindersClone
//
//  Created by Roman Potapov on 7/26/24.
//

import Foundation
import SwiftData


@Model
class MyList {
    var name: String
    var colorCode: String
    
    init(name: String, colorCode: String) {
        self.name = name
        self.colorCode = colorCode
    }
}
