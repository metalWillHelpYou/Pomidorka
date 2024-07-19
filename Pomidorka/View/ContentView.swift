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
    @EnvironmentObject var notificationManager: NotificationManager
    @Environment(\.scenePhase) var scenePhase
    
    @State private var showSettings = false
    @State private var showTimer = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 56) {
                if notificationManager.isGranted {
                    Image("Tomato")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                    
                    boostProductivityButton
                } else {
                    openSettingsButton
                }
            }
            .navigationTitle("Pomidorka")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .preferredColorScheme(userTheme.setTheme)
            .popover(isPresented: $showTimer, content: {
                TimerView()
                    .presentationCompactAdaptation(.fullScreenCover)
            })
            .toolbar {
                settingsLink
            }
            .task {
                try? await notificationManager.requestAutorization()
            }
            .onChange(of: scenePhase) { oldValue, newValue in
                if newValue == .active {
                    Task{
                        await notificationManager.getCurrentSettings()
                        await notificationManager.getPendingRequests()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NotificationManager())
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
    
    private var openSettingsButton: some View {
        Button(action: {
            notificationManager.openSettings()
        }, label: {
            Text("Turn on notifications")
                .padding()
                .padding(.horizontal)
                .background(Color.highlight)
                .foregroundStyle(Color.text)
                .font(.headline)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })
    }
}
