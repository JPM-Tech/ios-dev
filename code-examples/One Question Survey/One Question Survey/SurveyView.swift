//
//  SurveyView.swift
//  One Question Survey
//
//  Created by Chase Lewis on 4/20/23.
//

import SwiftUI

struct SurveyView: View {
    let surveyQuestion: SurveyQuestion

    var body: some View {
        VStack {
            Text(surveyQuestion.questionText).bold()
            
            ForEach(surveyQuestion.possibleAnswers, id: \.self) { answer in
                Button(answer) {
                    //submit response here
                    
                    //store the question to local memory to know that we have already answered the question
                }
                .buttonStyle(.bordered)
                .padding(4)
            }
        }
        .padding()
    }
}

struct SurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SurveyView(surveyQuestion: SurveyQuestion(id: "1", shouldDisplayQuestion: true, questionText: "This is a sample question", possibleAnswers: ["Answer 1", "Answer 2"]))
    }
}
