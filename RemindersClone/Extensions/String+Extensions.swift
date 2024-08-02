//
//  String+Extensions.swift
//  RemindersClone
//
//  Created by Roman Potapov on 8/2/24.
//

import Foundation

extension String {
    
    var isEmptyOrWithSpace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
