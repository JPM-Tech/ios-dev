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
    
    //from bard
    func postRequest<T>(to endpoint: URL, with body: T) async throws -> (Data, URLResponse) where T: Encodable {
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        return (data, response)
    }
    
    /*
     //The example of how it would be used
     let endpoint = URL(string: "https://example.com/api/v1/users")!
     let body = ["name": "John Doe", "email": "johndoe@example.com"]

     do {
         let (data, response) = try await postRequest(to: endpoint, with: body)
         
         // Handle the response
     } catch {
         // Handle the error
     }
     */
    
}
