//  ContentView.swift
import SwiftUI

struct ContentView: View {
    // Local state variables (used for keeping score, updating the slider position, and generating a random number
    @State private var randomNumber = Int.random(in: 1...100)
    @State private var sliderPosition = 50.0
    @State private var score = 0
    
    var body: some View {
        VStack {
            Text("🎯 BULLSEYE 🎯")
                .font(.title)
                .padding()
            
            Text("My Score is \(score) points")
            Spacer()
            Text("Match the slider as close as you can to the number:").multilineTextAlignment(.center)
            Text("\(randomNumber)")
            
            Slider(value: $sliderPosition, in: 1...100, step: 1.0) {
                Text("")
            } minimumValueLabel: {
                Text("1")
            } maximumValueLabel: {
                Text("100")
            }
            
            Button("TEST IT") {
                let difference = abs(randomNumber - Int(sliderPosition))
                
                // Scoring logic
                if difference == 0 {
                    score += 10
                } else if difference <= 5 {
                    score += 5
                } else if difference <= 10 {
                    score += 1
                }
                
                // Choose new random number
                randomNumber = Int.random(in: 1...100)
                
                // Reset slider to center
                sliderPosition = 50.0
            }.padding()
            Spacer()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

