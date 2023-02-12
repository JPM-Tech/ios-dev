//
//  PostViewModel.swift
//  api-call-example
//
//  Created by Chase Lewis on 2/12/23.
//

import Foundation

@MainActor class PostViewModel: ObservableObject {
    @Published var postData = [Post]()
    
    func fetchData() async {
        guard let downloadedPosts: [Post] = await WebService().downloadData(fromURL: "https://jsonplaceholder.typicode.com/posts") else {return}
        postData = downloadedPosts
    }
}
