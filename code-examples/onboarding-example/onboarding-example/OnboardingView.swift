//
//  OnboardingView.swift
//  onboarding-example
//
//  Created by Chase Lewis on 5/19/23.
//

import SwiftUI

struct OnboardingView: View {
    @State private var selectedView = 1
    @AppStorage(Constants.currentOnboardingVersion) private var hasSeenOnboardingView = false
    
    var body: some View {
        VStack {
            TabView(selection: $selectedView) {
                // Example screen 1
                OnboardingScreen(item: OnboardingItem(systemImageName: "clock.badge.checkmark", title: "Quick and Accurate", subtitle: "This app is quick and accuracte with all the measurements.")).tag(1)
                
                // Example screen 2
                OnboardingScreen(item: OnboardingItem(systemImageName: "dollarsign.circle", title: "Make money", subtitle: "With this app you can make money while you sleep.")).tag(2)
            }
            // Allows you to swipe through the tabs
            // if you only have one onboarding screen, the dots at the bottom of the screen that indicate what tab you are on, won't be displayed
            .tabViewStyle(.page)
            // Displays the background behind the tab indicator dots so that they can been seen in light and dark mode
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            Button(selectedView == 2 ? "Done" : "Next") {
                if selectedView == 2 {
                    // Save the completedOnboarding state and exit the view
                    hasSeenOnboardingView = true
                } else {
                    selectedView += 1
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.vertical)
        }
        .onAppear {
            // this can be uncommented out if we want to remove the old onboarding version from UserDefaults
//            UserDefaults.standard.removeObject(forKey: "previous_onboarding_version")
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
