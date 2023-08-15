//
//  CardAmountsView.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 05/08/2023.
//

import SwiftUI

struct CardAmountsView: View {
    let title: String
    let totalAmount: Int
    let monthAmouth: Int
    let percentage: Int
    let colorCard: Color
    var body: some View {
        VStack{
            ZStack {
              RoundedRectangle(cornerRadius: 10)
                    .shadow(radius: 5)
                    .foregroundColor(colorCard)
                
                HStack {
                    VStack(alignment: .leading, spacing: 10){
                        Text(title)
                            .bold()
                            .foregroundColor(.white)
                            .font(.largeTitle)
                                            
                        Text("Totales: $\(totalAmount)")
                            .bold()
                            .foregroundColor(.white)
                            .font(.title2)
                        HStack {
                            Text("Este mes: $\(monthAmouth)")
                                .bold()
                                .foregroundColor(.white)
                                .font(.title3)
                            
                            Spacer()
                            
                            Text("+ \(percentage)%")
                                .bold()
                        }

                        
                        Spacer()
                        
                    }
                    
                    Spacer()
                } // HSTACK
                .padding()
                
            } // ZSTACK
            .frame(height: 140)
            .padding()
        }
    }
}

struct CardAmountsView_Previews: PreviewProvider {
    static var previews: some View {
        CardAmountsView(title: "Ingresos", totalAmount: 100000, monthAmouth: 100000, percentage: 100, colorCard: Color.green)
    }
}
