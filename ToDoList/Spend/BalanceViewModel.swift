//
//  BalanceViewModel.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 09/08/2023.
//

import Foundation
import CoreData

class BalanceViewModel: ObservableObject {
    
    @Published var transactions: [Transaction] = []
    @Published var spends: [Transaction] = []
    @Published var incomes: [Transaction] = []
    
    private let viewContext = PersistenceController.shared.container.viewContext
    
    init(){
        fetchTransactionsData()
    }
    
    private func fetchTransactionsData() {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        
        do {
            transactions = try viewContext.fetch(request)
            spends.removeAll()
            incomes.removeAll()
            transactions.forEach { transaction in
                if transaction.type == 1 {
                    spends.append(transaction)
                } else {
                    incomes.append(transaction)
                }
            }
        }catch{
            print("DEBUG: Some error occured while fetching")
        }
    }
    
    func getTotalSpendsAmount() -> Double {
        var amount: Double = 0
        spends.forEach { spend in
            amount += spend.quantity
        }
        
        return amount
    }
    
    func getTotalIncomesAmount() -> Double {
        var amount: Double = 0
        incomes.forEach { income in
            amount += income.quantity
        }
        
        return amount
    }
    
    func addDataToCoreData(name: String, quantity: Double, type: Int, typeTransaction: String){
        let data = Transaction(context: viewContext)
        data.id = UUID()
        data.name = name
        data.quantity = quantity
        data.type = Int16(type)
        data.typeTransaction = typeTransaction
        
        save()
        
        self.fetchTransactionsData()
        
    }
    
    private func save(){
        do{
            try viewContext.save()
        }catch{
            print("Error saving")
        }
    }
    
    func deleteDataFromCoreData(offsets: IndexSet){
        offsets.map{ transactions[$0]}.forEach(viewContext.delete)
        
        save()
        
        self.fetchTransactionsData()
    }
    
}
