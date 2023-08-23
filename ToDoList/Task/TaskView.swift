//
//  TaskView.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 29/07/2023.
//

import SwiftUI

struct TaskView: View {
    @State var descriptionNote: String = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var notesViewModel: NotesViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 30){
            Text("Agregar una tarea")
                .bold()
                .font(.largeTitle)
                .padding(.top, 20)
            
            TextEditor(text: $descriptionNote)
                .frame(height: 100)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.green, lineWidth: 2)
                }
                .padding()
                .cornerRadius(3.0)
            
            
            Button {
                print("Creando nota")
                notesViewModel.saveNote(description: descriptionNote)
                descriptionNote = ""
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Crear")
                    .font(.title2)
                    .frame(width: 200, height: 50)
            }
            .disabled(descriptionNote.isEmpty ? true : false)
            .buttonStyle(.bordered)
            .tint(.green)
            
            Spacer()
            
        }
        .padding()
    }
}
