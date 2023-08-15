//
//  ToDoTask.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 29/07/2023.
//

import SwiftUI

struct ToDoTask: View {
    @State var isPresentedCreateNote = false
    @EnvironmentObject var notesViewModel: NotesViewModel
    
    var body: some View {
        NavigationView {
            VStack{
                List{
                    ForEach($notesViewModel.notes, id: \.id){$note in
                        HStack{
                            Text(note.description)
                            
                            Spacer()
                            
                            Image(systemName: note.isFavorite ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                notesViewModel.updateFavoriteNote(note: $note)
                            } label: {
                                Label("Favorito", systemImage: "star.fill")
                            }
                            .tint(.yellow)

                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                notesViewModel.removeNote(id: note.id)
                            } label: {
                                Label("Eliminar", systemImage: "trash.fill")
                            }
                            .tint(.red)

                        }
                    }
                }
                
            }
            .navigationTitle("Tareas")
            .toolbar {
                Text("\(notesViewModel.getNumberNotes())")
                    .foregroundColor(.yellow)
            }
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
