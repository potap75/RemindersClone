//
//  PreviewContainer.swift
//  RemindersClone
//
//  Created by Roman Potapov on 7/26/24.
//

import Foundation
import SwiftData


@MainActor
var previewContainer: ModelContainer = {
    
    let container = try! ModelContainer(for: MyList.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    for myList in SampleData.myLists{
        container.mainContext.insert(myList)
    }
    
    return container
}()


// MARK: - SAMPLE DATA

struct SampleData {
    static var myLists: [MyList] {
        return [MyList(name: "Reminders", colorCode: "#2ecc71"), MyList(name: "Backlog", colorCode: "#9b59b6")]
    }
}
