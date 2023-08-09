//
//  SurveyViewModel.swift
//  One Question Survey
//
//  Created by Chase Lewis on 4/20/23.
//

import Foundation

@MainActor class SurveyViewModel: ObservableObject {
    @Published var surveyData = [QuestionFields]()
    @Published var shouldShowRequestFeedbackButton = false
    @Published var shouldShowSurveyQuestion = false
    @Published var usersResponse = ""
    var question: QuestionFields?
    
    func fetchData() async {
        guard let result: Records = await WebService().downloadData(fromURL: "https://api.airtable.com/v0/\(Constants.baseId)/\(Constants.questionsTableId)") else {return}
        
        surveyData = result.records
            .map(\.fields)
            .compactMap(\.question)
            .filter { $0.shouldDisplayQuestion ?? false }
        
        if !questionHasAlreadyBeenAnswered(surveyData.first) {
            shouldShowRequestFeedbackButton = surveyData.first?.shouldDisplayQuestion ?? false
            question = surveyData.first ?? nil
        }
    }
    
    func sendAnswer() async {
        //make sure we have a question before trying to submit an ID
        guard let question = question else {return}
        let recordToSend: Records = Records(
            records: [
                Record(
                    id: nil, createdTime: nil, fields: Fields.answerFields(
                        AnswerFields(
                            id: question.id,
                            questionText: question.questionText,
                            answer: usersResponse,
                            sawThisComponent: 0,
                            sawThisQuestion: 0,
                            dismissedThisComponent: 0,
                            answeredThisQuestion: 1
                        )
                    )
                )
            ]
        )
        
        await WebService().create(records: recordToSend, toURL: "https://api.airtable.com/v0/\(Constants.baseId)/\(Constants.answersTableId)")
        
        dontShowThisQuestionAgain(question)
    }
    
    func sendSawThisComponent() async {
        //make sure we have a question before trying to submit an ID
        guard let question = question else {return}
        let recordToSend: Records = Records(
            records: [
                Record(
                    id: nil, createdTime: nil, fields: Fields.answerFields(
                        AnswerFields(
                            id: question.id,
                            questionText: question.questionText,
                            answer: usersResponse,
                            sawThisComponent: 1,
                            sawThisQuestion: 0,
                            dismissedThisComponent: 0,
                            answeredThisQuestion: 0
                        )
                    )
                )
            ]
        )
        
        await WebService().create(records: recordToSend, toURL: "https://api.airtable.com/v0/\(Constants.baseId)/\(Constants.answersTableId)")
    }
    
    func sendDismissedThisComponent() async {
        //make sure we have a question before trying to submit an ID
        guard let question = question else {return}
        let recordToSend: Records = Records(
            records: [
                Record(
                    id: nil, createdTime: nil, fields: Fields.answerFields(
                        AnswerFields(
                            id: question.id,
                            questionText: question.questionText,
                            answer: usersResponse,
                            sawThisComponent: 0,
                            sawThisQuestion: 0,
                            dismissedThisComponent: 1,
                            answeredThisQuestion: 0
                        )
                    )
                )
            ]
        )
        
        await WebService().create(records: recordToSend, toURL: "https://api.airtable.com/v0/\(Constants.baseId)/\(Constants.answersTableId)")
        
        dontShowThisQuestionAgain(question)
    }
    
    func sendSawThisQuestion() async {
        //make sure we have a question before trying to submit an ID
        guard let question = question else {return}
        let recordToSend: Records = Records(
            records: [
                Record(
                    id: nil, createdTime: nil, fields: Fields.answerFields(
                        AnswerFields(
                            id: question.id,
                            questionText: question.questionText,
                            answer: usersResponse,
                            sawThisComponent: 0,
                            sawThisQuestion: 1,
                            dismissedThisComponent: 0,
                            answeredThisQuestion: 0
                        )
                    )
                )
            ]
        )
        
        await WebService().create(records: recordToSend, toURL: "https://api.airtable.com/v0/\(Constants.baseId)/\(Constants.answersTableId)")
    }
    
    func questionHasAlreadyBeenAnswered(_ question: QuestionFields?) -> Bool {
        guard let question = question else {return false}
        //check UserDefaults to see if the id has been saved
        if UserDefaults.standard.string(forKey: question.id) != nil {
            return true
        }
        
        return false
    }
    
    func dontShowThisQuestionAgain(_ question: QuestionFields?) {
        guard let question = question else {return}
        
        UserDefaults.standard.set(question.id, forKey: question.id)
    }
}

// this extension helps us ensure we are decoding the question fields from our questions table
fileprivate extension Fields {
    var question: QuestionFields? {
        switch self {
        case .questionFields(let record):
            return record
        default:
            return nil
        }
    }
}
