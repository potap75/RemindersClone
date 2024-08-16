//
//  MyListsScreen.swift
//  RemindersClone
//
//  Created by Roman Potapov on 7/26/24.
//

import SwiftUI
import SwiftData

struct MyListsScreen: View {
    
    // MARK: - Temp Data
    
    @Query private var myLists: [MyList]
    @State private var isPresented: Bool = false
    @State private var selectedList: MyList?
    
    @State private var actionSheet: MyListScreenSheets?
    
    enum MyListScreenSheets: Identifiable {
        case newList
        case editList(MyList)
        
        var id: Int {
            switch self {
            case .newList:
                return 1
            case .editList(let myList):
                return myList.hashValue
            }
        }
    }
    
    var body: some View {
        List {
            Text("My Lists")
                .font(.largeTitle)
                .bold()
            
            ForEach(myLists, id: \.self) {myList in
                
                NavigationLink(value: myList) {
                    MyListCellView(myList: myList)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedList = myList
                        }
                        .onLongPressGesture(minimumDuration: 0.5) {
                            actionSheet = .editList(myList)
                        }
                }
            }
            Button(action: {
                actionSheet = .newList
            }, label: {
                Text("Add List")
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }).listRowSeparator(.hidden)
            
            
            
        }
        .navigationDestination(item: $selectedList, destination: { myList in
            
            MyListDetailScreen(myList: myList)
            
        })
        
        .listStyle(.plain)
        .sheet(item: $actionSheet) { actionSheet in
            
            switch actionSheet {
            case .newList:
                NavigationStack {
                    AddMyListScreen()
                }
            case .editList(let myList):
                NavigationStack {
                    AddMyListScreen(myList: myList)
                }
            }
            
        }
    }
}

#Preview { @MainActor in
    NavigationStack {
        MyListsScreen()
    }.modelContainer(previewContainer)
}



