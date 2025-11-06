//
//  QuizView.swift
//  QuizApp
//
//  Created by Meenakshi Pathani on 14/06/25.
//

import SwiftUI
import SwiftData

struct QuizView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    @StateObject private var viewModel = QuizViewModel()
    @StateObject private var timerViewModel = TimerViewModel(totalTime: 10)

    var body: some View {
        ZStack(){
            
            GradientBackground()
            
            VStack {
                if viewModel.isFinished {
                    QuizCompletedView(viewModel: viewModel)
                        
                } else if let _ = viewModel.currentQuestion {
                    QuestionaireView(viewModel: viewModel, timerViewModel: timerViewModel)

                } else {
                    ProgressView()
                }
            }
            .padding()
            .alert("⏰ Time’s Up!", isPresented: .constant(timerViewModel.isTimeout && !viewModel.isFinished)) {
                Button("Try Again") {
                    viewModel.restart()
                    timerViewModel.restartTimer()
                }
                Button("Exit", role: .cancel) {
                    dismiss()
                }
            } message: {
                Text("You ran out of time!")
            }
        }
        .onAppear {
            if viewModel.context == nil {
                viewModel.setContext(modelContext)
                print(viewModel.questions)
            }
        }
    }
}

#Preview {
    QuizView()
}


