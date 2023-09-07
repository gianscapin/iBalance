//
//  MainTabView.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 31/07/2023.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    var body: some View {
        TabView(selection: $selectedIndex) {
            ToDoTask()
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .environmentObject(TaskViewModel())
                .tabItem {
                    VStack {
                        Image(systemName: "rectangle.badge.checkmark")
                        Text("Tareas")
                    }
                }.tag(0)
            
            SpendMainView()
                .onTapGesture {
                    self.selectedIndex = 1
                }
                .tabItem {
                    VStack {
                        Image(systemName: "dollarsign.square")
                        Text("Gastos")
                    }
                }.tag(1)
            
            SettingsView()
                .onTapGesture {
                    self.selectedIndex = 2
                }
                .tabItem {
                    VStack {
                        Image(systemName: "slider.horizontal.3")
                        Text("Configuración")
                    }
                }.tag(2)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
