//
//  ContentView.swift
//  Pomidorka
//
//  Created by metalWillHelpYou on 17.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showTimer = false
    @State private var showSettings = false
    
    @AppStorage("workTime") var workTime = 25
    @AppStorage("relaxTime") var relaxTime = 5
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.opacity(0.5).ignoresSafeArea()
                
                VStack(spacing: 56) {
                    Image("Tomato")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                    
                    boostProductivityButton
                }
            }
            .navigationTitle("Pomidorka")
            .toolbar {
                NavigationLink(destination: SetUpTimerView()) {
                    Image(systemName: "gear")
                }
            }
            .popover(isPresented: $showTimer, content: {
                TimerView(workTime: workTime, relaxTime: relaxTime)
                    .presentationCompactAdaptation(.fullScreenCover)
            })
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView {
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
