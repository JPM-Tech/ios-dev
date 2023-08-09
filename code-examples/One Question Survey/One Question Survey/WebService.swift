//
//  WebService.swift
//  One Question Survey
//
//  Created by Chase Lewis on 6/14/23.
//

import Foundation

enum httpMethod: String {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case trace = "TRACE"
}

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

class WebService {
    func downloadData<T: Codable>(fromURL: String) async -> T? {
        do {
            guard let url = URL(string: fromURL) else { throw NetworkError.badUrl }
            var request = URLRequest(url: url)
            request.setValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            let (data, response) = try await URLSession.shared.data(for: request)
            // ----------------
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            
            return decodedResponse
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print(error)
            print("An error occured downloading the data")
        }
        
        return nil
    }
    
    func create(records: Records, toURL: String) async {
        do {
            guard let url = URL(string: toURL) else { throw NetworkError.badUrl }
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            guard let jsonBody = try? JSONEncoder().encode(records) else {return}
                        
            let (data, response) = try await URLSession.shared.upload(for: request, from: jsonBody)
            
            print("\nData", String(data: data, encoding: .utf8))
            print("\n\nResponse", response)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("Status Code", response.statusCode)
                throw NetworkError.badStatus
            }
            
            // we could use this to display the record update that was successfull.
            // but this implementation doesn't use the next line
            guard let decodedResponse = try? JSONDecoder().decode(Records.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            
            print("Successfully updated the record")
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading the data")
        }
    }
}
