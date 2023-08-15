//
//  NoteViewModel.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 29/07/2023.
//

import Foundation
import SwiftUI

class NotesViewModel: ObservableObject{
    @Published var notes: [NoteModel] = []
    @Published var isAddingNote = false
    
    init() {
        notes = getAllNotes()
    }
    
    
    func saveNote(description: String){
        let newNote = NoteModel(description: description)
        notes.insert(newNote, at: 0)
        encodeAndSaveAllNotes()
    }
    
    private func encodeAndSaveAllNotes(){
        if let encoded = try? JSONEncoder().encode(notes){
            UserDefaults.standard.set(encoded, forKey: "notes")
        }
    }
    
    func getAllNotes() -> [NoteModel] {
        if let notesData = UserDefaults.standard.object(forKey: "notes") as? Data {
            if let notes = try? JSONDecoder().decode([NoteModel].self, from: notesData){
                return notes
            }
        }
        
        return []
    }
    
    func removeNote(id: String){
        notes.removeAll(where: {$0.id == id})
        encodeAndSaveAllNotes()
    }
    
    func updateFavoriteNote(note: Binding<NoteModel>){
        note.wrappedValue.isFavorite = !note.wrappedValue.isFavorite
        encodeAndSaveAllNotes()
    }
    
    func getNumberNotes() -> Int {
        return notes.count
    }
}
