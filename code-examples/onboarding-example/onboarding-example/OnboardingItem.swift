//
//  OnboardingItem.swift
//  onboarding-example
//
//  Created by Chase Lewis on 5/19/23.
//

import Foundation

struct OnboardingItem: Identifiable, Hashable {
    let id = UUID()
    let systemImageName: String
    let title: String
    let subtitle: String
}
