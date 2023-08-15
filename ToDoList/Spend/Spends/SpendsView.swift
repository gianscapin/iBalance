//
//  SpendsView.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 31/07/2023.
//

import SwiftUI

struct SpendsView: View {
    let items = ["Item 1", "Item 2", "Item 3"]
    
    @EnvironmentObject var viewModel: BalanceViewModel
    
    
    @State private var isShowing: Bool = false
    
    private func deleteSpends(offsets: IndexSet){
        withAnimation{
            viewModel.deleteDataFromCoreData(offsets: offsets)
        }
    }
    
    var body: some View {
            VStack {
                CardAmountsView(title: "Gastos", totalAmount: Int(viewModel.getTotalSpendsAmount()), monthAmouth: Int(viewModel.getTotalSpendsAmount()), percentage: 100, colorCard: Color.red)
                
                HStack{
                    Button {
                        isShowing = true
                    } label: {
                        Text("Nuevo gasto")
                            .font(.title3)
                            .bold()
                            .frame(width: 180, height: 50)
                            .foregroundColor(.white)
                    }
                    .disabled(false)
                    .tint(.accentColor)
                    .buttonStyle(.borderedProminent)
                    .padding()
                    
                    Spacer()
                    
                    HStack{
                        Button {
                            // edit income
                        } label: {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 50)
                        }
                        .disabled(false)
                        .tint(.yellow)
                        .buttonStyle(.borderedProminent)
                        
                        Button {
                            // delete income
                        } label: {
                            Image(systemName: "xmark.bin.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 50)
                        }
                        .disabled(false)
                        .tint(.red)
                        .buttonStyle(.borderedProminent)
                        
                    }
                    .padding(.trailing, 16)
                }
                
                HStack{
                    Text("Movimientos")
                        .bold()
                        .font(.title)
                    
                    Spacer()
                    
                    Text("Ver todos")
                }
                .padding()
                
                if viewModel.transactions.filter({$0.type == 1}).isEmpty {
                    Text("No hay movimientos")
                } else {
                    List {
                        ForEach(viewModel.transactions.filter({$0.type == 1}), id: \.self) { transaction in
                            HStack{
                                Text(transaction.name!)
                                Spacer()
                                Text("$\(transaction.quantity)")
                            }
                        }
                        .onDelete(perform: deleteSpends)
                    }
                }
                
                Spacer()
            }
            .sheet(isPresented: $isShowing) {
                NewSpendView(isShowing: $isShowing)
                    .environmentObject(viewModel)
                    .presentationDetents([.medium])
            }
        }
}

struct SpendsView_Previews: PreviewProvider {
    static var previews: some View {
        SpendsView()
    }
}
