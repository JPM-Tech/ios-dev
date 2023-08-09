//
//  ContentView.swift
//  SF Symbols Tutorial
//
//  Created by Chase Lewis on 6/3/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image(systemName: "person.3.sequence.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
//            .foregroundColor(.red)
//            .symbolRenderingMode(.hierarchical)
//            .symbolRenderingMode(.multicolor)
            .foregroundStyle(.red, .green, .blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
