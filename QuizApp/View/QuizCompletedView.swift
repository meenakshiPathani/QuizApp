//
//  QuizCompletedView.swift
//  QuizApp
//
//  Created by Meenakshi Pathani on 14/06/25.
//

import SwiftUI
import SwiftData


struct QuizCompletedView: View {
    @ObservedObject var viewModel: QuizViewModel
    
    var body: some View {
        VStack(spacing:20) {
            AppText(text: "🎉 Quiz Complete!", size: AppFontSize.large.rawValue)
            
            AppText(text: "Your Score: \(viewModel.score) / \(viewModel.questions.count)", size: AppFontSize.medium.rawValue)
            
            Button("Restart Quiz", action: {
                viewModel.restart()
            })
            .buttonStyle(FilledButtonStyle())
            
        }
    }
}

#Preview {
    QuizCompletedView(viewModel: QuizViewModel())
}
