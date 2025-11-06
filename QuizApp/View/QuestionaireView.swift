//
//  QuestionaireView.swift
//  QuizApp
//
//  Created by Meenakshi Pathani on 15/06/25.
//

import SwiftUI

struct QuestionaireView: View {
    @ObservedObject var viewModel: QuizViewModel
    @ObservedObject var timerViewModel: TimerViewModel

    
    var body: some View {
        
        if let question = viewModel.currentQuestion {
            
            VStack(spacing: 30) {
                
//                Spacer().frame(height: 80) // fixed space at the top
                
                CircularTimerView(viewModel: timerViewModel)
                
                AppText(text: "Q\(viewModel.currentIndex + 1): \(question.question)", size: AppFontSize.medium.rawValue)
                
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(question.options, id: \.id) { option in
                        Button(action: {
                            viewModel.select(option: option)
                        }) {
                            HStack {
                                
                                AppText(text: option.text, size: AppFontSize.medium.rawValue)
                                
                                Spacer()
                                if viewModel.selectedOptionId == option.id {
                                    Image(systemName: option.id == question.answerId ? "checkmark.circle" : "xmark.circle")
                                        .foregroundColor(option.id == question.answerId ? .green : .red)
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(viewModel.selectedOptionId == option.id ? Color.white : Color.white.opacity(0.3), lineWidth: 2)
                            )
                        }
                        .disabled(viewModel.selectedOptionId != nil)
                    }
                }
                .padding()
                
                    Button("Next") {
                        viewModel.nextQuestion()
                    }
                    .disabled(viewModel.selectedOptionId == nil)
                    .buttonStyle(FilledButtonStyle())
                    .opacity(viewModel.selectedOptionId == nil  ? 0.7 : 1)
                    .padding(.top)
                Spacer()
            }
            .onAppear {
                       timerViewModel.restartTimer()
                   }
        } else {
            Text("No Questions found!")
        }
       
    }
}

#Preview {
    QuestionaireView(viewModel: QuizViewModel(), timerViewModel: TimerViewModel(totalTime: 10))
}
