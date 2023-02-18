//
//  ContentView.swift
//  hello world
//
//  Created by Chase Lewis on 2/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldShowPrayingEmoji = true
    
    var body: some View {
        VStack {
            Toggle(isOn: $shouldShowPrayingEmoji) {
                Text("Should show praying emoji")
            }
            
            Text("Tommy and Gina")
            Text(shouldShowPrayingEmoji ? "🙏" : "")
            Image(systemName: "figure.2.and.child.holdinghands")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
