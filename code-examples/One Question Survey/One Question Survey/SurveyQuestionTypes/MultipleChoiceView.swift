//
//  MultipleChoiceSurveyView.swift
//  One Question Survey
//
//  Created by Chase Lewis on 4/20/23.
//

import SwiftUI

struct MultipleChoiceView: View {
    let possibleAnswers: [String]
    @EnvironmentObject var vm: SurveyViewModel
    
    var body: some View {
        VStack {
            ForEach(possibleAnswers, id: \.self) { answer in
                Button {
                    vm.usersResponse = answer
                } label: {
                    Text(answer)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(vm.usersResponse == answer ? .white : .blue)
                }
                .padding()
                .background(vm.usersResponse == answer ? Color.accentColor : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(lineWidth: 1)
                        .foregroundColor(Color.accentColor)
                )
                .padding(.bottom, 4)
            }
        }
    }
}

struct MultipleChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleChoiceView(possibleAnswers: ["Answer 1", "Answer 2"])
            .padding()
            .environmentObject(SurveyViewModel())
    }
}
