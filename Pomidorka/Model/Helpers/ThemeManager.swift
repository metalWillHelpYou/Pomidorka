//
//  ThemeManager.swift
//  Pomidorka
//
//  Created by metalWillHelpYou on 18.07.2024.
//

import SwiftUI

enum Theme: String, CaseIterable {
    case system = "Default"
    case light = "Light"
    case dark = "Dark"
    
    var setTheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
