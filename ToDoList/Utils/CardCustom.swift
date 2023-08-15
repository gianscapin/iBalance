//
//  CardCustom.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 31/07/2023.
//

import SwiftUI

struct CardCustom: View {
    let name: String
    let quantity: String
    let color: Color
    var body: some View {
        ZStack {
          RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .frame(height: 70)
                .shadow(radius: 5)
            
            HStack{
                Text(name)
                    .bold()
                    .foregroundColor(.black)
                
                Spacer()
                
                Text(quantity)
                    .bold()
                    .foregroundColor(.black)
                Image(systemName: "arrow.right")
                    .foregroundColor(.black)
            }
            .padding()
        }
    }
}

struct CardCustom_Previews: PreviewProvider {
    static var previews: some View {
        CardCustom(name: "Gastos", quantity: "$100000", color: Color.red)
    }
}
