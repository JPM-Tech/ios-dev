//
//  SurveyView.swift
//  One Question Survey
//
//  Created by Chase Lewis on 6/13/23.
//

import SwiftUI

struct SurveyView: View {
    let surveyQuestion: QuestionFields
    @EnvironmentObject var vm: SurveyViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Question")
                .bold()
            
            Text(surveyQuestion.questionText)
                .padding(.bottom)
            
            if let possibleAnswers = surveyQuestion.possibleAnswers,
               surveyQuestion.questionType == QuestionType.multipleChoice {
                MultipleChoiceView(possibleAnswers: possibleAnswers)
            } else if surveyQuestion.questionType == QuestionType.fillInTheBlank {
                FillInTheBlankView()
            } else if surveyQuestion.questionType == QuestionType.rating {
                RatingView(numberOfChoices: surveyQuestion.numberOfRatingChoices ?? 0)
            } else {
                FillInTheBlankView()
            }
            
            HStack {
                Button("Cancel", role: .destructive) {
                    // close the modal
                    vm.shouldShowSurveyQuestion = false
                }
                
                Spacer()
                
                Button("Submit") {
                    // post to the AirTable endpoint
                    Task {
                        await vm.sendAnswer()
                    }
                                        
                    // hide the survey button
                    vm.shouldShowRequestFeedbackButton = false
                    
                    // close the modal
                    vm.shouldShowSurveyQuestion = false
                }
                .buttonStyle(.borderedProminent)
                .disabled(vm.usersResponse.isEmpty)
            }.padding(.top)
        }
        .padding()
        .task {
            await vm.sendSawThisQuestion()
        }
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        // some of these preview are commented out so that you can see what each component looks like as a whole view
        SurveyView(surveyQuestion: SampleQuestions.multipleChoice)
            .environmentObject(SurveyViewModel())
        
//        SurveyView(surveyQuestion: SampleQuestions.fillInTheBlank)
//        .environmentObject(SurveyViewModel())
        
//        SurveyView(surveyQuestion: SampleQuestions.rating)
//        .environmentObject(SurveyViewModel())
    }
}
