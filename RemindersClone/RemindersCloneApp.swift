//
//  RemindersCloneApp.swift
//  RemindersClone
//
//  Created by Roman Potapov on 7/26/24.
//

import SwiftUI
import SwiftData

@main
struct RemindersCloneApp: App {
    

    var body: some Scene {
        WindowGroup {
            NavigationStack{
                MyListsScreen()
            }
        }.modelContainer(for: MyList.self)
        
    }
}
