//
//  TaskViewModel.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 05/09/2023.
//

import Foundation
import CoreData

class TaskViewModel: ObservableObject {
    
    @Published var tasks: [TaskAction] = []
    @Published var tasksToDo: [TaskAction] = []
    @Published var tasksDoing: [TaskAction] = []
    @Published var tasksDone: [TaskAction] = []
    
    private let viewContext = PersistenceController.shared.container.viewContext
    
    init(){
        fetchTasksData()
    }
    
    
    private func fetchTasksData() {
        let request = NSFetchRequest<TaskAction>(entityName:"TaskAction")
        
        do{
            tasks = try viewContext.fetch(request)
            
            tasksToDo.removeAll()
            tasksDoing.removeAll()
            tasksDone.removeAll()
            
            tasks.forEach { task in
                if task.state == TaskState.TODO.stringValue {
                    tasksToDo.append(task)
                }
                if task.state == TaskState.DOING.stringValue {
                    tasksDoing.append(task)
                }
                if task.state == TaskState.DONE.stringValue {
                    tasksDone.append(task)
                }
            }
        }catch{
            print("DEBUG: Some error has occurred while requesting")
        }
    }
    
    func addTask(name: String, state: String? = TaskState.TODO.stringValue){
        let task = TaskAction(context: viewContext)
        task.id = UUID()
        task.name = name
        task.state = state
        task.time = Date()
        
        save()
        
        self.fetchTasksData()
    }
    
    private func save(){
        do{
            try viewContext.save()
        }catch{
            print("Error saving")
        }
    }
    
    func deleteTask(task: TaskAction){
        viewContext.delete(task)
        
        save()
        
        self.fetchTasksData()
    }
    
//    func deleteTaskDoing(task: TaskAction){
//        viewContext.delete(task)
//        
//        save()
//        
//        self.fetchTasksData()
//    }
//    
//    func deleteTaskDone(offsets: IndexSet){
//        for offset in offsets{
//            let item = tasksDone[offset]
//            viewContext.delete(item)
//        }
//        
//        save()
//        
//        self.fetchTasksData()
//    }
    
    func changeTaskToDoing(task: TaskAction){
            let request = NSFetchRequest<TaskAction>(entityName:"TaskAction")
            request.predicate = NSPredicate(format: "id = %@", task.id!.uuidString)
            do{
                guard let result = try viewContext.fetch(request) as? [TaskAction] else {
                    return
                }
                
                guard let taskEdit = result.first else { return }
                
                taskEdit.state = TaskState.DOING.stringValue
                
                save()
                self.fetchTasksData()
            }catch let error as NSError{
                debugPrint(error)
            }
    }
    
    func changeTaskToDone(task: TaskAction){
            let request = NSFetchRequest<TaskAction>(entityName:"TaskAction")
            request.predicate = NSPredicate(format: "id = %@", task.id!.uuidString)
            do{
                guard let result = try viewContext.fetch(request) as? [TaskAction] else {
                    return
                }
                
                guard let taskEdit = result.first else { return }
                
                taskEdit.state = TaskState.DONE.stringValue
                
                save()
                self.fetchTasksData()
            }catch let error as NSError{
                debugPrint(error)
            }
        }
}
