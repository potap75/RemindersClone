//
//  MyListDetailScreen.swift
//  RemindersClone
//
//  Created by Roman Potapov on 7/31/24.
//

import SwiftUI
import SwiftData


struct MyListDetailScreen: View {
    
    let myList: MyList
    
    var body: some View {
        VStack {
            List(myList.reminders) { reminder in
                Text(reminder.title)
            }
        }.navigationTitle(myList.name)
    }
}

struct MyListDetailScreenContainer: View {
    
    @Query private var myLists: [MyList]
    
    var body: some View {
        MyListDetailScreen(myList: myLists[0])
    }
}

#Preview { @MainActor in
    NavigationStack {
        MyListDetailScreenContainer()
            .modelContainer(previewContainer)
    }
}
