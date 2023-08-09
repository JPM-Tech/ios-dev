//
//  RatingView.swift
//  One Question Survey
//
//  Created by Chase Lewis on 6/14/23.
//

import SwiftUI

struct RatingView: View {
    let numberOfChoices: Int
    @EnvironmentObject var vm: SurveyViewModel
    @State private var selectedChoice = 0
    
    var body: some View {
        HStack {
            ForEach(1...numberOfChoices, id: \.self) { index in
                Button {
                    selectedChoice = index
                    vm.usersResponse = String(selectedChoice)
                } label: {
                    Image(systemName: "star")
                        .symbolVariant(index <= selectedChoice ? .fill : .none)
                }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(numberOfChoices: 5)
            .environmentObject(SurveyViewModel())
    }
}
