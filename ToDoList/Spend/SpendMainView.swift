//
//  SpendMainView.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 31/07/2023.
//

import SwiftUI

struct SpendMainView: View {
    
    @StateObject var viewModel = BalanceViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                VStack {
                    VStack(spacing: 0){
                        NavigationLink(destination: IncomeView().environmentObject(viewModel)) {
                            CardCustom(name: "Ingresos", quantity: "$100000", color: Color.green)
                                .padding()
                        }
                        NavigationLink(destination: SpendsView().environmentObject(viewModel)) {
                            CardCustom(name: "Gastos", quantity: "$100000", color: Color.red)
                                .padding()
                        }
                    }
                    HStack{
                        Text("Ultimos movimientos")
                            .bold()
                        Spacer()
                        Text("5 días")
                            .bold()
                    }
                    .padding()
                    
                    ScrollView {
                        LazyVStack() { 
                            
                        }
                    }
                    
                    Spacer()
                    
                }
                .navigationTitle("Balance")
            } // GROUP
        } // NAVIGATIONVIEW
    }
}

struct SpendMainView_Previews: PreviewProvider {
    static var previews: some View {
        SpendMainView()
    }
}
