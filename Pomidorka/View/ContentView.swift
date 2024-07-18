//
//  ContentView.swift
//  Pomidorka
//
//  Created by metalWillHelpYou on 17.07.2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("userTheme") private var userTheme: Theme = .system
    @AppStorage("workTime") var workTime = 25
    @AppStorage("relaxTime") var relaxTime = 5
    
    @State private var showTimer = false
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 56) {
                Image("Tomato")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                
                boostProductivityButton
            }
            .navigationTitle("Pomidorka")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .preferredColorScheme(userTheme.setTheme)
            .popover(isPresented: $showTimer, content: {
                TimerView(workTime: workTime, relaxTime: relaxTime)
                    .presentationCompactAdaptation(.fullScreenCover)
            })
            .toolbar {
                settingsLink
            }
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    private var settingsLink: some View {
        NavigationLink(destination: SettingsView()) {
            Image(systemName: "gear")
                .foregroundStyle(Color.highlight)
        }
    }
    
    private var boostProductivityButton: some View {
        Button(action: {
            showTimer.toggle()
        }, label: {
            Text("Boost productivity")
                .padding()
                .padding(.horizontal)
                .background(Color.highlight)
                .foregroundStyle(Color.text)
                .font(.headline)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })
    }
}
