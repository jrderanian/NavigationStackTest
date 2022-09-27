//
//  ContentView.swift
//  NavigationStackTest
//
//  Created by John Deranian on 9/26/22.
//

import SwiftUI


//struct DestinationView: View {
//    var body: some View {

struct ContentView: View {
    
    @State private var stackPath = NavigationPath()
    @State private var toggleStatus = true
    @State var listData: [ToDoItem] = [
        ToDoItem(task: "Take out trash", imageName: "trash.circle.fill"),
        ToDoItem(task: "Pick up the kids", imageName: "person.2.fill"),
        ToDoItem(task: "Wash the car", imageName: "car.fill")
    ]
    
    var body: some View {
        NavigationStack(path: $stackPath){
            List {
                Section(header: Text("Settings")) {
                    Toggle(isOn: $toggleStatus) {
                        Text("Allow Notifications")
                    }
                }
                
                NavigationLink(value: listData.count) {
                                Text("View Task Count")
                            }
                
                
                Section(header: Text("To Do Tasks")) {
                    ForEach (listData) { item in
                        NavigationLink(value: item.task) {
                            HStack {
                                Image(systemName: item.imageName)
                                Text(item.task)
                            }}
                    }
                }
                
            }
            /*
            .refreshable {
                listData = [
                    ToDoItem(task: "Order dinner", imageName: "dollarsign.circle.fill"),
                    ToDoItem(task: "Call financial advisor", imageName: "phone.fill"),
                    ToDoItem(task: "Sell the kids", imageName: "person.2.fill")
                ]
            }
             */
            //.navigationBarTitle(Text("To Do List"))
            .navigationDestination(for: String.self) { task in
                Text("Selected task = \(task)")
            }
            .navigationDestination(for: Int.self) { count in
                Text("Number of tasks = \(count)")
            }

        }
    }
}

struct ToDoItem : Identifiable {
    var id = UUID()
    var task: String
    var imageName: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
