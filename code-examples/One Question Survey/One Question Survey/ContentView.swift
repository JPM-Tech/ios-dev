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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .sheet(isPresented: $vm.shouldShowSurveyQuestion, content: {
            if let myQuestion = vm.surveyData.first,
               myQuestion.shouldDisplayQuestion == true {
                SurveyView(surveyQuestion: myQuestion)
            }
        })
        .task {
            if vm.surveyData.isEmpty {
                await vm.fetchData()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
