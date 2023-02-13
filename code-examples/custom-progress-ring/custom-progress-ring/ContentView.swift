//
//  ContentView.swift
//  custom-progress-ring
//
//  Created by Chase Lewis on 2/12/23.
//

import SwiftUI

struct ContentView: View {
    let myProgess = 0.6
    
    var body: some View {
        VStack {
            CustomProgressRing(
                progress: myProgess,
                backgroundRingColor: .secondary,
                primaryRingColor: .blue,
                ringLineWidth: 24
            )
            
            HStack {
                Text(myProgess, format: .percent)
                Text("Complete")
            }
            .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
