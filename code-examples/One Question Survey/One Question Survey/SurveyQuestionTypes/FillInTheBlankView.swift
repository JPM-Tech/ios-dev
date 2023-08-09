//
//  FillInTheBlankView.swift
//  One Question Survey
//
//  Created by Chase Lewis on 6/13/23.
//

import SwiftUI

struct FillInTheBlankView: View {
    @EnvironmentObject var vm: SurveyViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            TextEditor(text: $vm.usersResponse)
                .border(Color.secondary)
        }
    }
}

struct FillInTheBlankView_Previews: PreviewProvider {
    static var previews: some View {
        FillInTheBlankView()
            .environmentObject(SurveyViewModel())
    }
}
