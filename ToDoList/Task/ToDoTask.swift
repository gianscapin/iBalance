//
//  ToDoTask.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 29/07/2023.
//

import SwiftUI

struct ToDoTask: View {
    @State var isPresentedCreateNote = false
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    let tasks: [TaskAction] = []
    
    var body: some View {
        NavigationView {
                VStack{
                    List{
                        Section("Tareas por hacer") {
                            if !taskViewModel.tasksToDo.isEmpty{
                                ForEach($taskViewModel.tasksToDo, id: \.self){$task in
                                    HStack{
                                        Text(task.name!)

                                    }
                                    .swipeActions(edge: .trailing) {
                                        Button {
                                                    //                                    notesViewModel.updateFavoriteNote(note: $note)
                                            taskViewModel.changeTaskToDoing(task: task)
                                        } label: {
                                            Text("DOING")
                                        }
                                        .tint(.yellow)
                                                
                                    }
                                    .swipeActions(edge: .leading) {
                                        Button {
                                                    //                                    notesViewModel.removeNote(id: note.id)
                                            taskViewModel.deleteTask(task: task)
                                        } label: {
                                            Label("Eliminar", systemImage: "trash.fill")
                                        }
                                        .tint(.red)
                                                
                                    }
                                }
                            } else {
                                HStack {
                                    Text("No hay tareas asignadas.")
                                        .multilineTextAlignment(TextAlignment.center)
                                    Spacer()
                                }
                            }
                        }
                        
                        Section("Tareas haciendo") {
                            if !taskViewModel.tasksDoing.isEmpty{
                                ForEach($taskViewModel.tasksDoing, id: \.self){$task in
                                    HStack{
                                        Text(task.name!)
                                            .bold()
                                        
                                    }
                                    .swipeActions(edge: .trailing) {
                                        Button {
                                                    //                                    notesViewModel.updateFavoriteNote(note: $note)
                                            taskViewModel.changeTaskToDone(task: task)
                                        } label: {
                                            Text("DONE")
                                        }
                                        .tint(.yellow)
                                                
                                    }
                                    .swipeActions(edge: .leading) {
                                        Button {
                                                    //                                    notesViewModel.removeNote(id: note.id)
                                            taskViewModel.deleteTask(task: task)
                                        } label: {
                                            Label("Eliminar", systemImage: "trash.fill")
                                        }
                                        .tint(.red)
                                                
                                    }
                                }
                            } else {
                                HStack {
                                    Text("No hay tareas ejecutándose.")
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                }
                            }
                        }
                        
                        Section("Tareas terminadas") {
                            if !taskViewModel.tasksDone.isEmpty{
                                ForEach($taskViewModel.tasksDone, id: \.self){$task in
                                    HStack{
                                        Text(task.name!)

                                    }
                                    .swipeActions(edge: .trailing) {
                                        Button {
                                                    //                                    notesViewModel.updateFavoriteNote(note: $note)
                                            taskViewModel.changeTaskToDoing(task: task)
                                        } label: {
                                            Text("DOING")
                                        }
                                        .tint(.yellow)
                                                
                                    }
                                    .swipeActions(edge: .leading) {
                                        Button {
                                                    //                                    notesViewModel.removeNote(id: note.id)
                                            taskViewModel.deleteTask(task: task)
                                        } label: {
                                            Label("Eliminar", systemImage: "trash.fill")
                                        }
                                        .tint(.red)
                                                
                                    }
                                }
                            } else {
                                HStack {
                                    Text("No hay tareas terminadas.")
                                    Spacer()
                                }
                            }
                        }
                    }
                                    
                }
                .listStyle(GroupedListStyle())
            .navigationTitle("Tareas")
    //                .toolbar {
    //                    Text("\(notesViewModel.getNumberNotes())")
    //                        .foregroundColor(.yellow)
    //                }
                }
            .sheet(isPresented: $isPresentedCreateNote, content: {
                TaskView()
                    .presentationDetents([.medium])
            })
            .overlay(alignment: .bottomTrailing) {
                Button {
                    // Add task
                    isPresentedCreateNote.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 100)
                        .foregroundColor(.blue)
                }
                .padding()
            }
            
    }
}

struct ToDoTask_Previews: PreviewProvider {
    static var previews: some View {
        ToDoTask()
    }
}
