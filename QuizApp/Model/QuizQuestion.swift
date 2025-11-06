//
//  QuizModel.swift
//  QuizApp
//
//  Created by Meenakshi Pathani on 14/06/25.
//

import SwiftData

@Model
class QuizQuestion {
    var id: String
    var question: String
    var options: [QuizOption]
    var answerId: String
    
    init(id: String, question: String, options: [QuizOption], answerId: String) {
        self.id = id
        self.question = question
        self.options = options
        self.answerId = answerId
    }
}

@Model
class QuizOption {
    var id: String
    var text: String

    init(id: String, text: String) {
        self.id = id
        self.text = text
    }
}

