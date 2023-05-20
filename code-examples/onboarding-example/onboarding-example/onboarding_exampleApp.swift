//
//  onboarding_exampleApp.swift
//  onboarding-example
//
//  Created by Chase Lewis on 5/19/23.
//

import SwiftUI

@main
struct onboarding_exampleApp: App {
    @AppStorage(Constants.currentOnboardingVersion) private var hasSeenOnboardingView = false
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboardingView {
                ContentView()
            } else {
                OnboardingView()
            }
        }
    }
}
