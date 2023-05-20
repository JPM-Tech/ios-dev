//
//  OnboardingScreen.swift
//  onboarding-example
//
//  Created by Chase Lewis on 5/19/23.
//

import SwiftUI

struct OnboardingScreen: View {
    let item: OnboardingItem
        
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: item.systemImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200, maxHeight: 200)
                    .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text(item.title)
                        .bold()
                        .font(.title)
                        .padding(.bottom)
                    
                    Text(item.subtitle)
                        .padding(.bottom)
                }
            }
            .padding()
        }
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen(item: OnboardingItem(systemImageName: "clock.badge.checkmark", title: "Onboarding", subtitle: "Using this is actually a really huge time savings. You can do so many awesome things with this app, it's not even funny."))
    }
}
