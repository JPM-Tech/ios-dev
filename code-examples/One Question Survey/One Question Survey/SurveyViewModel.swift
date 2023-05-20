//
//  SurveyViewModel.swift
//  One Question Survey
//
//  Created by Chase Lewis on 4/20/23.
//

import Foundation

class Constants {
    static let baseId = "your_base_ID"
    static let apiKey = "your_api_key"
}

enum TableName: String {
    case Questions, Answers
}

@MainActor class SurveyViewModel: ObservableObject {
    @Published var surveyData = [SurveyQuestion]()
    @Published var shouldShowSurveyQuestion = false
    
    func fetchData() async {
        guard let downloadedSurveys: [SurveyQuestion] = await WebService().downloadData(fromURL: "https://api.airtable.com/v0/\(Constants.baseId)/\(TableName.Questions.rawValue)") else {return}
        surveyData = downloadedSurveys
        shouldShowSurveyQuestion = surveyData.first?.shouldDisplayQuestion ?? false
    }
    
    func sendData() async {
        
    }
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
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            
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
            print("An error occured downloading the data")
        }
        
        return nil
    }
    
    func sendData<T: Codable>(toURL: String) async -> T? {
        do {
            guard let url = URL(string: toURL) else { throw NetworkError.badUrl }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
            
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
            print("An error occured downloading the data")
        }
        
        return nil
    }
}
