//
//  PersistenceController.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 05/08/2023.
//

import CoreData
struct PersistenceController {
    // PERSISTENT CONTROLLER
    static let shared = PersistenceController()
    
    // PERSISTENT CONTAINER
    let container: NSPersistentContainer

    // INITIALIZATION (load the persistent core)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // PREVIEW
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let newItem = Transaction(context: viewContext)
            newItem.name = "Compra 1"
            newItem.quantity = 100
            newItem.type = 1
            newItem.typeTransaction = "Tipo 1"
            newItem.id = UUID()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}

