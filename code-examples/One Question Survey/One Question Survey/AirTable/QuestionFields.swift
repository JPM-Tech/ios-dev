//
//  QuestionFields.swift
//  One Question Survey
//
//  Created by Chase Lewis on 4/19/23.
//

import Foundation

struct QuestionFields: Codable {
    let id: String
    let shouldDisplayQuestion: Bool?
    let questionText: String
    let possibleAnswers: [String]?
    let numberOfRatingChoices: Int?
    let questionType: QuestionType
}
