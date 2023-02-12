//
//  Post.swift
//  api-call-example
//
//  Created by Chase Lewis on 2/12/23.
//

import Foundation

struct Post: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
