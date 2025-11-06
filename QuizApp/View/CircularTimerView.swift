//
//  CircularTimerView.swift
//  QuizApp
//
//  Created by Meenakshi Pathani on 12/08/25.
//

import SwiftUI
import Combine

struct CircularTimerView: View {
    
    @ObservedObject var viewModel: TimerViewModel

    let lineWidth: CGFloat = 15
   

    var body: some View {
        ZStack {
            // Background Circle
            Circle()
                .stroke(Color.white.opacity(0.2), lineWidth: lineWidth)

            // Foreground Progress Circle
            Circle()
                .trim(from: 0, to: viewModel.progress)
                .stroke(Color.white, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90)) // Start from top
                .animation(.easeInOut(duration: 0.5), value: viewModel.progress)

            // Center Label
            Text("\(viewModel.timeRemaining)s")
                .font(.largeTitle)
                .foregroundColor(.white)
                .bold()
        }
        .frame(width: 150, height: 150)
        .onAppear {
                    viewModel.startTimer()
                }
                .onDisappear {
                    viewModel.stopTimer()
                }
    }
    
}
