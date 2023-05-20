//
//  SurveyQuestion.swift
//  One Question Survey
//
//  Created by Chase Lewis on 4/19/23.
//

import Foundation

struct SurveyQuestion: Codable, Identifiable {
    let id: String
    let shouldDisplayQuestion: Bool
    let questionText: String
    let possibleAnswers: [String]
}
