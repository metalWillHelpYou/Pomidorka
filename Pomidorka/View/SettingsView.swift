//
//  SettingsView.swift
//  Pomidorka
//
//  Created by metalWillHelpYou on 18.07.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("userTheme") private var userTheme: Theme = .system
    @AppStorage("workTime") var workTime = 25
    @AppStorage("relaxTime") var relaxTime = 5
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    themePicker
                    Text("Notificsations")
                    Text("Language")
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
                
                setupTimer
            }
            .navigationTitle("Settings")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background.opacity(0.5))
            .preferredColorScheme(userTheme.setTheme)
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    private var themePicker: some View {
        Picker("Apperance", selection: $userTheme) {
            ForEach(Theme.allCases, id: \.self) { theme in
                Text(theme.rawValue).tag(theme)
            }
        }
    }
    
    private var setupTimer: some View {
        VStack {
            Spacer()
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.highlight, lineWidth: 2)
                    .frame(width: 350, height: 350)
                
                VStack {
                    Spacer()
                    timePickers
                    
                    Spacer()
                    
                    setDefaultValuesButton
                }
            }
            
            Spacer()
        }
    }
    
    private var timePickers: some View {
        HStack(spacing: 20) {
            VStack {
                Text("Work time")
                
                Picker("Work Time", selection: $workTime) {
                    ForEach(0..<60) { minute in
                        Text("\(minute) m").tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 80, height: 100)
            }
            
            VStack {
                Text("Relax time")
                
                Picker("Minutes", selection: $relaxTime) {
                    ForEach(0..<30) { minute in
                        Text("\(minute) m").tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 80, height: 100)
            }
        }
    }
    
    private var setDefaultValuesButton: some View {
        Button(action: {
            setDefaultValues()
        }, label: {
            Text("Reset")
                .padding()
                .padding(.horizontal)
                .background(Color.highlight)
                .foregroundStyle(Color.text)
                .font(.headline)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })
        .padding(.vertical)
    }
    
    private func setDefaultValues() {
        workTime = 25
        relaxTime = 5
    }
}
