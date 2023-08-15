//
//  NewSpendView.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 05/08/2023.
//

import SwiftUI

struct NewSpendView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var viewModel: BalanceViewModel
    
    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var tipo: String = ""
    
    let options = ["Suscripción", "Educación", "Comida", "Ocio", "Otros"]
    
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text("Nuevo gasto")
                .font(.title)
                .bold()
                .padding()
            
            
            TextField("Nombre", text: $name)
                .font(.system(size: 18, design: .rounded))
                .padding()
                .foregroundColor(.red)
                .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.red, lineWidth: 2))
                .keyboardType(.numberPad)
                .padding()
            
            TextField("Cantidad", text: $quantity)
                .font(.system(size: 18, design: .rounded))
                .padding()
                .foregroundColor(.red)
                .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.red, lineWidth: 2))
                .padding()
            
            Picker("Tipo de gasto", selection: $tipo){
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
                        viewModel.addDataToCoreData(name: name, quantity: Double(quantity) ?? 0, type: 1, typeTransaction: tipo)
                        
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
                .tint(.red)
                Spacer()
            }
            .padding()
            

            
            Spacer()
        }
    }
}

struct NewSpendView_Previews: PreviewProvider {
    static var previews: some View {
        NewSpendView(isShowing: .constant(true))
    }
}
