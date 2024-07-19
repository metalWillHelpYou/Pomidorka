//
//  PomidorkaApp.swift
//  Pomidorka
//
//  Created by metalWillHelpYou on 17.07.2024.
//

import SwiftUI

@main
struct PomidorkaApp: App {
    @StateObject var notificationManager = NotificationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notificationManager)
        }
    }
}
