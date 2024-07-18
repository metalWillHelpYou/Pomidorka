//
//  TimerView.swift
//  Pomidorka
//
//  Created by metalWillHelpYou on 17.07.2024.
//

import SwiftUI

struct TimerView: View {
    @AppStorage("workTime") private var workTime = 25
    @AppStorage("relaxTime") private var relaxTime = 5
    @Environment(\.dismiss) var dismiss
    
    @State private var isTimerRunning = false
    @State private var timeRemaining: Int = 0
    @State private var isWorkTime = true
    
    var body: some View {
        VStack {
            Spacer()
            
            timer
            
            Spacer()
            
            HStack(spacing: 16) {
                stopButton
                pauseButton
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
        .onAppear {
            resetTimer()
            isTimerRunning.toggle()
            startTimer()
        }
        .onChange(of: workTime) { oldWorkTime, newWorkTime in
            if isWorkTime {
                resetTimer()
            }
        }
        .onChange(of: relaxTime) { oldRelaxTime, newRelaxTime in
            if !isWorkTime {
                resetTimer()
            }
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
                Text(isWorkTime ? "Work Time:" : "Relax Time:")
                    .font(.title)
                    .foregroundStyle(.white)
                
                Text("\(formattedString(from: timeRemaining))")
                    .font(.title)
                    .foregroundStyle(.white)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var pauseButton: some View {
        Button(action: {
            isTimerRunning.toggle()
            if isTimerRunning {
                startTimer()
            }
        }, label: {
            Text(isTimerRunning ? "Pause" : "Start")
                .frame(maxWidth: .infinity)
                .padding()
                .padding(.horizontal)
                .background(Color.highlight)
                .foregroundColor(.text)
                .font(.headline)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })
    }
    
    private var stopButton: some View {
        Button(action: {
            isWorkTime = false
            isTimerRunning = false
            dismiss()
        }, label: {
            Text("Stop")
                .padding()
                .padding(.horizontal)
                .background(Color.cancel)
                .foregroundStyle(.black)
                .font(.headline)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })
    }
}

extension TimerView {
    private func resetTimer() {
        timeRemaining = (isWorkTime ? workTime : relaxTime) * 60
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if !isTimerRunning {
                timer.invalidate()
            } else if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isWorkTime.toggle()
                resetTimer()
            }
        }
    }
    
    private func formattedString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
