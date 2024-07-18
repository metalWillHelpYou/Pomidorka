//
//  SetUpTimerView.swift
//  Pomidorka
//
//  Created by metalWillHelpYou on 17.07.2024.
//

import SwiftUI

struct SetUpTimerView: View {
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("workTime") var workTime = 25
    @AppStorage("relaxTime") var relaxTime = 5
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.highlight, lineWidth: 2)
                        .frame(width: 350, height: 350)
                    
                    pickers
                }
                
                Spacer()
            }
            .navigationTitle("Set up your time")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background.opacity(0.5))
        }
    }
}

#Preview {
    SetUpTimerView()
}

extension SetUpTimerView {
    private var pickers: some View {
        HStack(spacing: 20) {
             VStack {
                Text("Select work time")
                 
                Picker("Work Time", selection: $workTime) {
                    ForEach(0..<60) { minute in
                        Text("\(minute) m").tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 80, height: 100)
            }
            
            VStack {
                Text("Select relax time")
                
                Picker("Minutes", selection: $relaxTime) {
                    ForEach(0..<60) { minute in
                        Text("\(minute) m").tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 80, height: 100)
            }
        }
        .padding(.top, 40)
    }
}
