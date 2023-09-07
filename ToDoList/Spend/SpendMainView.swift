//
//  SpendMainView.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 31/07/2023.
//

import SwiftUI

struct SpendMainView: View {
    
    @StateObject var viewModel = BalanceViewModel()
    @State private var valueBalance: Float = 0.0
    
    
    private func getPercentage() -> Float {
        if viewModel.getTotalSpendsMonth() == 0 {
            return 0
        }
        if viewModel.getTotalIncomesMonth() == 0 {
            return 100
        }
        
        return Float(viewModel.getTotalSpendsMonth() * 100 / viewModel.getTotalIncomesMonth())
        
        
    }
    
    
    var body: some View {
        NavigationView {
            Group {
                VStack {
                    VStack(spacing: 0){
                        
                        CircleResumeView(valueBalance: getPercentage())
                        
                        NavigationLink(destination: IncomeView().environmentObject(viewModel)) {
                            CardCustom(name: "Ingresos", quantity: "$ \(viewModel.getTotalIncomesMonth())", color: Color.green.opacity(0.8))
                                .padding()
                        }
                        NavigationLink(destination: SpendsView().environmentObject(viewModel)) {
                            CardCustom(name: "Gastos", quantity: "$ \(getAmount(amount: viewModel.getTotalSpendsMonth()))", color: Color.red.opacity(0.8))
                                .padding()
                        }
                        
                    }
                    
                    HStack{
                        Text("Valor dolar: ")
                        if let dolar = viewModel.dolarBlue {
                            Text("$ \(getAmount(amount: dolar))")
                                .foregroundColor(Color.green)
                        } else {
                            Text("Cargando..")
                        }
                    }
                    .onAppear{
                        Task{
                            await viewModel.fetchDolar()
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
                    
                    if viewModel.transactions.isEmpty {
                        Text("No hay movimientos recientes")
                    }else{
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                    ForEach(viewModel.getTransactionsLessThan5Days(), id: \.self){ transaction in
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(transaction.type == 0 ? Color.green.opacity(0.4)
                                                      : Color.red.opacity(0.4))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .strokeBorder(transaction.type == 0 ? Color.green : Color.red)
                                                )
                                            
                                            HStack{
                                                Text(transaction.typeTransaction!)
                                                Spacer()
                                                
                                                if transaction.type == 0 {
                                                    Image(systemName: "arrow.up")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 20, height: 20)
                                                }else{
                                                    Image(systemName: "arrow.down")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 20, height: 20)
                                                }
                                                
                                                
                                                Text("$\(getAmount(amount:transaction.quantity))")
                                                    .bold()
                                            }
                                            .padding()
                                        }
                                        .padding(.horizontal, 10)
                                    }
                                
                            }

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
