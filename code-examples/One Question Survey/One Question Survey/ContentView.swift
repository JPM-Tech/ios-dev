//
//  ContentView.swift
//  One Question Survey
//
//  Created by Chase Lewis on 4/19/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = SurveyViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                Spacer()
            }
            
            if vm.shouldShowRequestFeedbackButton && vm.question != nil {
                ShareFeedbackButton(surveyQuestion: vm.surveyData.first ?? SampleQuestions.fillInTheBlank)
            }
        }
        .padding()
        .task {
            if vm.surveyData.isEmpty {
                await vm.fetchData()
            }
        }
        .environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SurveyViewModel())
    }
}
