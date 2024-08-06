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
    @State private var reminderTitle: String = ""
    @State private var isNewReminderAlertPresented: Bool = false
    @State private var selectedReminder: Reminder?
    @State private var showReminderEditScreen: Bool = false
    
    private var isFormValid: Bool {
        !reminderTitle.isEmptyOrWithSpace
    }
    
    private func saveReminder() {
        let reminder = Reminder(title: reminderTitle)
        myList.reminders.append(reminder)
    }
    
    var body: some View {
        VStack {
            List(myList.reminders) { reminder in
                ReminderCellView(reminder: reminder, isSelected: false) { event in
                    switch event {
                    case .onChecked(let reminder, let checked):
                        reminder.isComplete = checked
                    case .onSelect(let reminder):
                        selectedReminder = reminder
                    case .onInfoSelected(let reminder):
                        showReminderEditScreen = true
                        selectedReminder = reminder
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                isNewReminderAlertPresented = true
            }, label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("New Reminder")
                }
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }.alert("New Reminder", isPresented: $isNewReminderAlertPresented) {
                TextField("", text: $reminderTitle)
                Button("Cancel", role: .cancel) { }
                Button("Done") {
                    if isFormValid {
                        saveReminder()
                    }
                }
            }
        .navigationTitle(myList.name)
        .sheet(isPresented: $showReminderEditScreen, content: {
            if let selectedReminder {
                NavigationStack {
                    ReminderEditScreen(reminder: selectedReminder)
                }
            }
        })
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
