//
//  ContentView.swift
//  Pomidorka
//
//  Created by metalWillHelpYou on 17.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showTimer = false
    
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
            .popover(isPresented: $showTimer, content: {
                TimerView()
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
                .frame(width: 150, height: 24)
                .padding()
                .padding(.horizontal)
                .background(Color.background)
                .foregroundStyle(Color.text)
                .font(.headline)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })
    }
}
