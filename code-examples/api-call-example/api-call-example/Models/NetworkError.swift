//
//  NetworkError.swift
//  api-call-example
//
//  Created by Chase Lewis on 2/12/23.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}
