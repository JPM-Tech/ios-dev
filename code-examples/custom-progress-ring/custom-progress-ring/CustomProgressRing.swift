//
//  CustomProgressRing.swift
//  custom-progress-ring
//
//  Created by Chase Lewis on 2/12/23.
//

import SwiftUI

struct CustomProgressRing: View {
    let progress: Double
    let backgroundRingColor: Color
    let primaryRingColor: Color
    let ringLineWidth: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(backgroundRingColor, lineWidth: ringLineWidth)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    style: StrokeStyle(
                        lineWidth: ringLineWidth,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .fill(primaryRingColor)
                .rotationEffect(.degrees(-90))
        }
    }
}

struct CustomProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressRing(progress: 0.1, backgroundRingColor: .secondary, primaryRingColor: .blue, ringLineWidth: 15)
            .padding()
    }
}
