//
//  SampleQuestions.swift
//  One Question Survey
//
//  Created by Chase Lewis on 6/14/23.
//

import Foundation

class SampleQuestions {
    static let fillInTheBlank = QuestionFields(id: UUID().uuidString, shouldDisplayQuestion: true, questionText: "What is the biggest and best way this app has provided value to your life?", possibleAnswers: [], numberOfRatingChoices: nil, questionType: .fillInTheBlank)
    static let multipleChoice = QuestionFields(id: UUID().uuidString, shouldDisplayQuestion: true, questionText: "How important is this really cool feature to you?", possibleAnswers: ["Not Important", "Neutral", "Important"], numberOfRatingChoices: nil, questionType: .multipleChoice)
    static let rating = QuestionFields(id: UUID().uuidString, shouldDisplayQuestion: true, questionText: "How would you rate this really cool new feature?", possibleAnswers: [], numberOfRatingChoices: 8, questionType: .rating)
}
