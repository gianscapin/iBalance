//
//  NewIncomeView.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 05/08/2023.
//

import SwiftUI

struct NewIncomeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var viewModel: BalanceViewModel
    
    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var tipo: String = ""
    
    @State private var showAlert = false

    
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
                .padding()
            
            TextField("Cantidad", text: $quantity)
                .font(.system(size: 18, design: .rounded))
                .padding()
                .foregroundColor(.green)
                .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.green, lineWidth: 2))
                .keyboardType(.numberPad)
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
                    if name.isEmpty || quantity.isEmpty || tipo.isEmpty{
                        showAlert = true
                    }else{
                        withAnimation {
                            viewModel.addDataToCoreData(name: name, quantity: Double(quantity) ?? 0, type: 0, typeTransaction: tipo)
                            
                            name = ""
                            quantity = ""
                            
                            isShowing = false
                            
                        }
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
                .alert(isPresented: $showAlert){
                    Alert(title: Text("Campos incompletos"), message: Text("Por favor, completa todos los campos."))
                }
                
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
