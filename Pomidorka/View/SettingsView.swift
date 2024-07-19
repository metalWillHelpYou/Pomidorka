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
        Picker("Appearance", selection: $userTheme) {
            ForEach(Theme.allCases, id: \.self) { theme in
                Text(theme.rawValue).tag(theme)
            }
        }
    }
    
    private var setupTimer: some View {
        VStack {
            Spacer()
            
            Text("Set up your time")
                .font(.title)
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
                    .font(.headline)
                
                Picker("Work Time", selection: $workTime) {
                    ForEach(1..<61) { minute in
                        Text("\(minute) m").tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 80, height: 100)
            }
            
            VStack {
                Text("Relax time")
                    .font(.headline)
                
                Picker("Minutes", selection: $relaxTime) {
                    ForEach(1..<31) { minute in
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
            Text("Set as default")
                .padding()
                .padding(.horizontal)
                .background(Color.highlight)
                .foregroundStyle(Color.text)
                .font(.headline)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 10)
        })
        .padding(.vertical)
    }
    
    private func setDefaultValues() {
        workTime = 25
        relaxTime = 5
    }
}
