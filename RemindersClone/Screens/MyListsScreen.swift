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
    
   
    
    var body: some View {
        List {
            Text("My Lists")
                .font(.largeTitle)
                .bold()
            
            ForEach(myLists, id: \.self) {myList in
                
                NavigationLink {
                    MyListDetailScreen(myList: myList)
                } label: {
                    HStack{
                        Image(systemName: "line.3.horizontal.circle.fill")
                            .font(.system(size: 32))
                            .foregroundStyle(Color(hex: myList.colorCode))
                        Text(myList.name)
                    }
                }
            }
            Button(action: {
                isPresented = true
            }, label: {
                Text("Add List")
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }).listRowSeparator(.hidden)
            
            
            
        }.listStyle(.plain)
            .sheet(isPresented: $isPresented, content: {
                NavigationStack {
                    AddMyListScreen()
                }
            })
    }
}

#Preview { @MainActor in
    NavigationStack {
        MyListsScreen()
    }.modelContainer(previewContainer)
}

