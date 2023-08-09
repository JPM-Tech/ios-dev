//
//  AnswerFields.swift
//  One Question Survey
//
//  Created by Chase Lewis on 6/26/23.
//

import Foundation

struct AnswerFields: Codable {
    let id: String
    let questionText: String
    let answer: String?
    let sawThisComponent: Int
    let sawThisQuestion: Int
    let dismissedThisComponent: Int
    let answeredThisQuestion: Int
}
