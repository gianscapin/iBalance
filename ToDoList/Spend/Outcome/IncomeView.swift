//
//  OutcomeView.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 31/07/2023.
//

import SwiftUI

struct IncomeView: View {
    let items = ["Item 1", "Item 2", "Item 3"]
    
    @EnvironmentObject var viewModel: BalanceViewModel
    
    
    @State private var isShowing: Bool = false
    
    private func deleteIncome(offsets: IndexSet){
        withAnimation{
            viewModel.deleteIncomeFromCoreData(offsets: offsets)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                CardAmountsView(title: "Ingresos", totalAmount: Int(viewModel.getTotalIncomesAmount()), monthAmouth: Int(viewModel.getTotalIncomesMonth()), percentage: 100, colorCard: Color.green.opacity(0.8))
                
                
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

                
                if viewModel.transactions.filter({$0.type == 0}).isEmpty {
                    Text("No hay movimientos")
                } else {
                    List {
                        ForEach(viewModel.transactions.filter({$0.type == 0}), id: \.self) { transaction in
                            HStack{
                                Text(transaction.name!)
                                Spacer()
                                Text("$\(getAmount(amount:transaction.quantity))")
                            }
                        }
                        .onDelete(perform: deleteIncome)
                    }
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $isShowing) {
            NewIncomeView(isShowing: $isShowing)
                .environmentObject(viewModel)
                .presentationDetents([.medium])
        }
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView()
    }
}
