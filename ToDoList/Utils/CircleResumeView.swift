//
//  CircleResumeView.swift
//  ToDoList
//
//  Created by Gianfranco Scapin on 24/08/2023.
//

import SwiftUI

struct CircleResumeView: View {
    var valueBalance: Float
    @State private var value: Float = 0.0
    
    private func getPercentageAmount(amount: Double) -> String {
        if amount > 100 {
            return getAmount(amount: 100)
        } else {
            return getAmount(amount: amount)
        }
    }
    
    var body: some View {
        VStack{
//            Slider(value: $value)
            ZStack{
                
                
                    Circle()
                        .stroke(Color.gray, lineWidth: 20)
                        .opacity(0.3)
                
                    
                    Circle()
                        .trim(from: 0, to: 100)
                        .stroke(Color.green.opacity(0.8), lineWidth: 20)
                        .rotationEffect(.degrees(90))
                
                Circle()
                    .trim(from: 0, to: CGFloat(min(self.value, 1.0)))
                    .stroke(Color.red.opacity(0.8), lineWidth: 20)
                    .rotationEffect(Angle(degrees: 270.0))
                    .overlay(Text("\(getPercentageAmount(amount:Double(valueBalance))) %"))
                    .onAppear{
                        value = valueBalance / 100
                    }
                
            }
            .padding()
            .frame(height: 200)
        }
        
    }
}

struct CircleResumeView_Previews: PreviewProvider {
    static var previews: some View {
        CircleResumeView(valueBalance: 0.6)
    }
}
