//
//  NewIncomeView.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 05/08/2023.
//

import SwiftUI

struct NewIncomeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var tipo: String = ""
    
    let options = ["Inversión", "Salario", "Transacción"]
    
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text("Nuevo ingreso")
                .font(.title)
                .bold()
                .padding()
            
            
            TextField("Nombre", text: $name)
                .font(.system(size: 18, design: .rounded))
                .padding()
                .foregroundColor(.green)
                .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.green, lineWidth: 2))
                .keyboardType(.numberPad)
                .padding()
            
            TextField("Cantidad", text: $quantity)
                .font(.system(size: 18, design: .rounded))
                .padding()
                .foregroundColor(.green)
                .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.green, lineWidth: 2))
                .padding()
            
            Picker("Tipo de ingreso", selection: $tipo){
                ForEach(options, id: \.self){option in
                    Text(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
                .foregroundColor(.green)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Spacer()
                
                Button {
                    withAnimation {
                        let income = Transaction(context: viewContext)
                        income.id = UUID()
                        income.name = name
                        income.quantity = Double(quantity) ?? 0
                        income.type = 0
                        income.typeTransaction = tipo
                        
                        do {
                            try viewContext.save()
                        }catch{
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                        
                        name = ""
                        quantity = ""
                        
                        isShowing = false
                        
                    }
                } label: {
                    Text("Crear")
                        .bold()
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 200)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                Spacer()
            }
            .padding()
            

            
            Spacer()
        }
    }
}

struct NewIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        NewIncomeView(isShowing: .constant(true))
    }
}
