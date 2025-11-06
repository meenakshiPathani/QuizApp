//
//  OptionModel.swift
//  QuizApp
//
//  Created by Meenakshi Pathani on 14/06/25.
//

struct QuizData: Decodable {
    let quiz: [QuizQuestionData]
}

struct QuizQuestionData: Decodable {
    let id: String
    let question: String
    let options: [QuizOptionData]
    let answerId: String
}

struct QuizOptionData: Decodable {
    let id: String
    let text: String
}


