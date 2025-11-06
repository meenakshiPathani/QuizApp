//
//  TimerViewModel.swift
//  QuizApp
//
//  Created by Meenakshi Pathani on 15/08/25.
//

import SwiftUI
import Combine

@MainActor
class TimerViewModel: ObservableObject {
    @Published var timeRemaining: Int
    @Published var progress: CGFloat = 1.0
    @Published var isTimeout = false

    private var totalTime: Int
    private var timer: AnyCancellable?

    var onComplete: (() -> Void)?

    init(totalTime: Int, onComplete: (() -> Void)? = nil) {
        self.totalTime = totalTime
        self.timeRemaining = totalTime
        self.onComplete = onComplete
    }

    func startTimer() {
        stopTimer() // Ensure clean state
        self.isTimeout = false
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }

                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    progress = CGFloat(timeRemaining) / CGFloat(totalTime)
                } else {
                    self.stopTimer()
                    self.onComplete?()
                }
            }
    }

    func stopTimer() {
        self.isTimeout = true
        timer?.cancel()
        timer = nil
    }

    func restartTimer() {
        timeRemaining = totalTime
        startTimer()
    }
}


