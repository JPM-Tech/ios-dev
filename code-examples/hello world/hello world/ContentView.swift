//
//  ContentView.swift
//  hello world
//
//  Created by Chase Lewis on 2/13/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Tommy and Gina")
            Text("🙏")
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
