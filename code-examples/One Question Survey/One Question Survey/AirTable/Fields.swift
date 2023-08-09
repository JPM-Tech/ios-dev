//
//  Fields.swift
//  One Question Survey
//
//  Created by Chase Lewis on 6/26/23.
//

import Foundation

enum Fields: Codable {
    case questionFields(QuestionFields)
    case answerFields(AnswerFields)
    
    func encode(to encoder: Encoder) throws {
        switch self {
        case .questionFields(let a0):
            try a0.encode(to: encoder)
        case .answerFields(let a0):
            try a0.encode(to: encoder)
        }
    }
    
    init(from decoder: Decoder) throws {
        if let question = try? QuestionFields(from: decoder) {
            self = .questionFields(question)
        } else if let answer = try? AnswerFields(from: decoder) {
            self = .answerFields(answer)
        } else {
            throw NSError()
        }
    }
}
