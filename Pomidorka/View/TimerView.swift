//
//  TimerView.swift
//  Pomidorka
//
//  Created by metalWillHelpYou on 17.07.2024.
//

import SwiftUI

struct TimerView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isTimeRunning = false
    
    var body: some View {
        VStack {
            Spacer()
            
            timer
            
            Spacer()
            
            stopButton
        }
        .background(.black)
    }
}

#Preview {
    TimerView()
}

extension TimerView {
    private var timer: some View {
        ZStack {
            Circle()
                .stroke(.white, lineWidth: 2)
                .frame(width: 350, height: 350)
            
            VStack(spacing: 16) {
                Text("Time remaining:")
                    .font(.title)
                    .foregroundStyle(.white)
                
                Text("25:00")
                    .font(.title)
                    .foregroundStyle(.white)
                
                pauseButton
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var pauseButton: some View {
        Button(action: {
            
        }, label: {
            Text("Pause")
                .padding()
                .padding(.horizontal)
                .background(.white)
                .foregroundStyle(.black)
            
                .font(.headline)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })
        .padding(.top)
    }
    
    private var stopButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            Text("Stop")
                .frame(height: 24)
                .frame(maxWidth: .infinity)
                .padding()
                .padding(.horizontal)
                .background(Color.red)
                .foregroundStyle(.black)
                .font(.headline)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })
        .padding(.horizontal, 24)
    }
}
