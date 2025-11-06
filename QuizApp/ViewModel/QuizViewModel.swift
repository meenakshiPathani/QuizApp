//
//  QuizVM.swift
//  QuizApp
//
//  Created by Meenakshi Pathani on 14/06/25.
//

import SwiftUI
import SwiftData

@MainActor
class QuizViewModel: ObservableObject {
    @Published var currentIndex = 0
    @Published var score = 0
    @Published var isFinished = false

    @Published var selectedOptionId: String? = nil
    @Published var questions: [QuizQuestion] = []
    
    private(set) var context: ModelContext? = nil

    func setContext(_ context: ModelContext) {
            self.context = context
            loadQuestions()
    }

    func loadQuestions() {
        guard let context else { return }

        let descriptor = FetchDescriptor<QuizQuestion>()
        do {
            self.questions = try context.fetch(descriptor)
        } catch {
            print("❌ Failed to fetch questions: \(error)")
        }
    }

    var currentQuestion: QuizQuestion? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    func select(option: QuizOption) {
        guard let question = currentQuestion else { return }

        selectedOptionId = option.id

        if option.id == question.answerId {
            score += 1
        }
    }

    func nextQuestion() {
        selectedOptionId = nil
        currentIndex += 1
        if currentIndex >= questions.count {
            isFinished = true
        }
    }

    func restart() {
        currentIndex = 0
        score = 0
        isFinished = false
        selectedOptionId = nil
    }
}

