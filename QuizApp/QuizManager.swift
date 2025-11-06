//
//  QuizManager.swift
//  QuizApp
//
//  Created by Meenakshi Pathani on 12/08/25.
//

import UIKit
import SwiftData

class QuizManager {
    
    static let shared = QuizManager()  // Singleton instance

    private init() {}
    
    func isFirstLaunch() -> Bool {
        let launchedKey = "hasLaunchedBefore"
        let hasLaunched = UserDefaults.standard.bool(forKey: launchedKey)
        if !hasLaunched {
            UserDefaults.standard.set(true, forKey: launchedKey)
        }
        return !hasLaunched
    }

    func loadQuizJSON() -> [QuizQuestionData] {
        guard let url = Bundle.main.url(forResource: "QuizData", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(QuizData.self, from: data) else {
            print("❌ Failed to load or decode quiz.json")
            return []
        }
        return decoded.quiz
    }

    func importQuizDataIfFirstLaunch(context: ModelContext) {
        if isFirstLaunch() {
            do {
                let questions = loadQuizJSON()
                for questionData in questions {
                    let options = questionData.options.map {
                        QuizOption(id: $0.id, text: $0.text)
                    }
                    let question = QuizQuestion(
                        id: questionData.id,
                        question: questionData.question,
                        options: options,
                        answerId: questionData.answerId
                    )
                    print(question)
//                    for option in options {
//                        context.insert(option)
//                    }
                    context.insert(question)
                   
                }
              
                try context.save()
                print("✅ Quiz data imported.")
            } catch {
                // Handle the error
                print("An unexpected error occurred: \(error.localizedDescription)")
            }
            
        }
    }

    
}

