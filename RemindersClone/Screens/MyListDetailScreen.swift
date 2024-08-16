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
    
    @Environment(\.modelContext) private var context
    
    private let delay = Delay()
    
    private var isFormValid: Bool {
        !reminderTitle.isEmptyOrWithSpace
    }
    
    private func saveReminder() {
        let reminder = Reminder(title: reminderTitle)
        myList.reminders.append(reminder)
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        reminder.persistentModelID == selectedReminder?.persistentModelID
    }
    
    private func deleteReminder (_ indexSet: IndexSet) {
   
        guard let index = indexSet.last else { return }
        let reminder = myList.reminders[index]
        context.delete(reminder)
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(myList.reminders.filter{ !$0.isComplete } ) { reminder in
                    ReminderCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                        switch event {
                        case .onChecked(let reminder, let checked):
                            // cancel current task
                            delay.cancel()
                            
                            // perform the delayed task
                            
                            delay.performWork {
                                reminder.isComplete = checked
                            }
                            
                            
                        case .onSelect(let reminder):
                            selectedReminder = reminder
                        case .onInfoSelected(let reminder):
                            showReminderEditScreen = true
                            selectedReminder = reminder
                        }
                    }
                }.onDelete(perform: deleteReminder)
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
                        reminderTitle = ""
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
