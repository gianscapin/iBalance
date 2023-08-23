//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 29/07/2023.
//

import SwiftUI

@main
struct ToDoListApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
