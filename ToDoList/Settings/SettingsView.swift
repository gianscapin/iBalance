//
//  SettingsView.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 31/07/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isOnlineMode") private var isOnlineMode = false
    
    var body: some View {
        Form{
            Section(header: Text("Configuración")) {
                Toggle(isOn: $isDarkMode) {
                    Text("Modo oscuro")
                }
                
                Toggle(isOn: $isOnlineMode) {
                    Text("Modo online")
                }
            }
        }
        .navigationTitle("Configuración")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
