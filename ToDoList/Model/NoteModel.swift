//
//  NoteModel.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 29/07/2023.
//

import Foundation

struct NoteModel: Codable {
    let id: String
    var isFavorite: Bool
    let description: String
    
    init(id: String = UUID().uuidString, isFavorite: Bool = false, description: String){
        self.id = id
        self.isFavorite = isFavorite
        self.description = description
    }
}
