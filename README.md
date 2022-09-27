#  <#Title#>

https://www.answertopia.com/swiftui/swiftui-navigationstack-and-navigationlink-overview/


To make items in a list navigable, the first step is to embed the entire list within a NavigationStack. Once the list is embedded, the individual rows must be wrapped in a NavigationLink control which is, in turn, passed a value that uniquely identifies each navigation link within the context of the NavigationStack.

The following changes to our example code embed the List view in a NavigationStack and wrap the row content in a NavigationLink:


NavigationStack {
    List {
        Section(header: Text("Settings")) {
            Toggle(isOn: $toggleStatus) {
                Text("Allow Notifications")
            }
        }
                
        Section(header: Text("To Do Tasks")) {
            ForEach (listData) { item in
                NavigationLink(value: item.task) {
                    HStack {
                        Image(systemName: item.imageName)
                        Text(item.task)
                    }
                }
            }
        }
    }
}















Note that we have used the item task string as the NavigationLink value to uniquely identify each row. The next step is to specify the destination view to which the user is to be taken when the row is tapped. We achieve this by applying the navigationDestination(for:) modifier to the list. When adding this modifier, we need to pass it the value type for which it is to provide navigation. In our example we are using the task string, so we need to specify String.self as the value type. Within the trailing closure of the navigationDestination(for:) call we need to call the view that is to be displayed when the row is selected. This closure is passed the value from the NavigationLink, allowing us to display the appropriate view:

NavigationStack {   
    List {
.
.
        Section(header: Text("To Do Tasks")) {
            ForEach (listData) { item in
                NavigationLink(value: item.task) {
                    HStack {
                        Image(systemName: item.imageName)
                        Text(item.task)
                    }
                }
            }
        }
    }
    .navigationDestination(for: String.self) { task in
        Text("Selected task = \(task)")
    }
}


In this example, the navigation link will simply display a new screen containing the destination Text view displaying the item.task string value. The finished list will appear as shown in Figure 30-6 with the title and chevrons on the far right of each row now visible indicating that navigation is available. Tapping the links will navigate to and display the destination Text view



The navigationDestination() modifier is particularly useful for adding navigation support to lists containing values of different types, with each type requiring navigation to a specific view. Suppose, for example, that in addition to the string-based task navigation link, we also have a NavigationLink which is passed an integer value indicating the number of tasks in the list. This could be implemented in our example as follows:

NavigationStack {
    
    List {
        
        Section(header: Text("Settings")) {
            Toggle(isOn: $toggleStatus) {
                Text("Allow Notifications")
            }

            NavigationLink(value: listData.count) {
                Text("View Task Count")
            }
        }
.
.

When this link is selected, we need the app to navigate to a Text view that displays the current task count. All this requires is a second navigationDestination() modifier, this time configured to handle Int instead of String values:

}
    .navigationDestination(for: String.self) { task in
        Text("Selected task = \(task)")
    }
    .navigationDestination(for: Int.self) { count in
        Text("Number of tasks = \(count)")
    }
