//
//  ShareFeedbackButton.swift
//  One Question Survey
//
//  Created by Chase Lewis on 6/13/23.
//

import SwiftUI

struct ShareFeedbackButton: View {
    let surveyQuestion: QuestionFields
    @EnvironmentObject var vm: SurveyViewModel
    
    var body: some View {
            HStack {
                Button {
                    // launch partial sheet that holds feedback component
                    vm.shouldShowSurveyQuestion.toggle()
                } label: {
                    HStack {
                        Label("Share Your Feedback", systemImage: "message.fill")
                        Spacer()
                    }
                }
                
                Button {
                    Task {
                        await vm.sendDismissedThisComponent()
                    }
                    vm.shouldShowRequestFeedbackButton = false
                } label: {
                    Image(systemName: "xmark")
                }.padding(.leading)
            }
            .padding()
            .foregroundColor(.white)
            .background(
                LinearGradient(colors: [.cyan, .blue, .purple], startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .sheet(isPresented: $vm.shouldShowSurveyQuestion) {
                SurveyView(surveyQuestion: surveyQuestion)
                    .presentationDetents([.height(250), .medium, .large])
                //presentationDetents allows us to have a sheet that only takes part of the height (or full sheet height with the .large option)
            }
            .task {
                await vm.sendSawThisComponent()
            }
    }
}

struct FeedbackButton_Previews: PreviewProvider {
    static var previews: some View {
        ShareFeedbackButton(surveyQuestion: SampleQuestions.fillInTheBlank)
            .padding()
            .environmentObject(SurveyViewModel())
    }
}
