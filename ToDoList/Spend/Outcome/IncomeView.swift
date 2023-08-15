//
//  OutcomeView.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 31/07/2023.
//

import SwiftUI

struct IncomeView: View {
    let items = ["Item 1", "Item 2", "Item 3"]
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var viewModel: BalanceViewModel
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.quantity, ascending: true)],
        animation: .default)
    private var transactions: FetchedResults<Transaction>
    
    
    @State private var isShowing: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                CardAmountsView(title: "Ingresos", totalAmount: 100000, monthAmouth: 100000, percentage: 100, colorCard: Color.green)
                
                
                HStack{
                    Button {
                        isShowing = true
                    } label: {
                        Text("Nuevo ingreso")
                            .font(.title3)
                            .bold()
                            .frame(width: 180, height: 50)
                            .foregroundColor(.white)
                    }
                    .disabled(false)
                    .tint(.green)
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

                
                if transactions.filter({$0.type == 0}).isEmpty {
                    Text("No hay movimientos")
                } else {
                    List {
                        ForEach(transactions.filter({$0.type == 0}), id: \.self) { transaction in
                            HStack{
                                Text(transaction.name!)
                                Spacer()
                                Text("$\(transaction.quantity)")
                            }
                        }
                    }
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $isShowing) {
            NewIncomeView(isShowing: $isShowing)
            NewIncomeView(isShowing: $isShowing)
                .presentationDetents([.medium])
        }
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView()
    }
}
