//
//  ContentView.swift
//  api-call-example
//
//  Created by Chase Lewis on 2/9/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = PostViewModel()
    
    var body: some View {
        List(vm.postData) { post in
            HStack {
                Text("\(post.userId)")
                    .padding()
                    .overlay(Circle().stroke(.blue))
                
                VStack(alignment: .leading) {
                    Text(post.title)
                        .bold()
                        .lineLimit(1)
                    
                    Text(post.body)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
        }
        .onAppear {
            if vm.postData.isEmpty {
                Task {
                    await vm.fetchData()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
