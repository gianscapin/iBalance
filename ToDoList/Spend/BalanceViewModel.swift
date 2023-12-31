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
    @Published var spendsMonth: [Transaction] = []
    @Published var incomes: [Transaction] = []
    @Published var incomesMonth: [Transaction] = []
    @Published var dolarBlue: Double? = 0.0
    
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
            spendsMonth.removeAll()
            incomesMonth.removeAll()
            
            transactions.forEach { transaction in
                if transaction.type == 1 {
                    spends.append(transaction)
                } else {
                    incomes.append(transaction)
                }
            }
            
            incomesMonth = getIncomesMonth()
            spendsMonth = getSpendsMonth()
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
    
    func addDataToCoreData(name: String, quantity: Double, type: Int, typeTransaction: String, date: Date? = nil){
        let data = Transaction(context: viewContext)
        data.id = UUID()
        data.name = name
        data.quantity = quantity
        data.type = Int16(type)
        data.timestamp = date ?? Date()
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
    
    func deleteIncomeFromCoreData(offsets: IndexSet){
        for offset in offsets{
            let item = incomes[offset]
            viewContext.delete(item)
        }
//        offsets.map{ transactions[$0]}.forEach(viewContext.delete)
        
        save()
        
        self.fetchTransactionsData()
    }
    
    func deleteSpendFromCoreData(offsets: IndexSet){
        for offset in offsets{
            let item = spends[offset]
            viewContext.delete(item)
        }
//        offsets.map{ transactions[$0]}.forEach(viewContext.delete)
        
        save()
        
        self.fetchTransactionsData()
    }
    
    func getTransactionsLessThan5Days() -> [Transaction]{
        let calendar = Calendar.current
        let currentDate = Date()
        let fiveDaysAgo = calendar.date(byAdding: .day, value: -5, to: currentDate)
        
        let transactions = transactions.filter{ transaction in
            return transaction.timestamp! > fiveDaysAgo! && transaction.timestamp! < currentDate
        }
        
        return transactions
    }
    
    private func getIncomesMonth() -> [Transaction]{
        let calendar = Calendar.current
        let currentDate = Date()
        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)
        
        let transactions = incomes.filter{ transaction in
            let transactionMonth = calendar.component(.month, from: transaction.timestamp!)
            let transactionYear = calendar.component(.year, from: transaction.timestamp!)
            return transactionMonth == month && transactionYear == year
        }
        
        return transactions
    }
    
    func getTotalIncomesMonth() -> Double {
        var amount: Double = 0
        incomesMonth.forEach{ income in
            amount += income.quantity
        }
        
        return amount
    }
    
    func getTotalSpendsMonth() -> Double {
        var amount: Double = 0
        spendsMonth.forEach{ income in
            amount += income.quantity
        }
        
        return amount
    }
    
    private func getSpendsMonth() -> [Transaction]{
        let calendar = Calendar.current
        let currentDate = Date()
        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)
        
        let transactions = spends.filter{ transaction in
            let transactionMonth = calendar.component(.month, from: transaction.timestamp!)
            let transactionYear = calendar.component(.year, from: transaction.timestamp!)

            return transactionMonth == month && transactionYear == year
        }
        
        return transactions
    }
    
    private func getDolarValue() async throws -> Double {
        
        guard let url = URL(string: "https://dolarapi.com/v1/dolares/blue") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let price = json["venta"] as? Double else {
            throw NSError(domain: "Invalid JSON", code: 0, userInfo: nil)
        }
        
        return price
        
    }
    
    func fetchDolar() async {
        do {
            let blue = try await getDolarValue()
            self.dolarBlue = blue
        } catch {
            self.dolarBlue = 0
        }
    }
    
}
