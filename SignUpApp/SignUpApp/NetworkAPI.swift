//
//  NetworkAPI.swift
//  SignUpApp
//
//  Created by Lia on 2021/04/01.
//

import Foundation

class NetworkAPI {
    typealias ExistID = [String]

    enum NetworkError: Int, Error {
        case badURL
        case invalidResponse
        case networkingError
        case unknown
        case decodingError
        case badRequest = 400
        case Unauthorized = 401
        case notFoundException = 404
        case contentLengthError = 413
        case quotaExceeded = 429
        case systemError = 500
        case endpointError = 503
        case timeout = 504
        case serverError
    }
    
    // MARK: 1. Session 생성
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    
    func fetchData(from urlString: String, completion: @escaping (Result<ExistID, NetworkError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        // MARK: 2. Request
        let request = URLRequest(url: url) // default: GET
        
        performTask(request: request, completion: parseJason(completion: completion))
    }
    
    // network error 처리
    private func performTask(request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        // MARK: 3. DataTask
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.networkingError))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(data))

                case 400...499:
                    completion(.failure(NetworkError(rawValue: httpResponse.statusCode) ?? .unknown))

                case 500...599:
                    completion(.failure(NetworkError(rawValue: httpResponse.statusCode) ?? .serverError))

                default:
                    fatalError("Unhandled HTTP status code: \(httpResponse.statusCode)")
                }
            }
        }.resume()
    }
    
    private func parseJason (completion: @escaping (Result<ExistID, NetworkError>) -> Void) -> (Result<Data, NetworkError>) -> Void {
        return { result in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = JSONDecoder()
                    let object = try jsonDecoder.decode(ExistID.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(object))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                     completion(.failure(error))
                 }
            }
        }
    }
    
    //MARK: POST
   func requestPost(from urlString: String, json: [String: String], completion: @escaping (Result<NetworkResult, NetworkError>) -> Void) {
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData

        performPostTask(request: request, completion: parseJasonForPost(completion: completion))
        
}

    private func performPostTask(request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        // MARK: 3. DataTask
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.networkingError))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(data))

                case 400...499:
                    completion(.failure(NetworkError(rawValue: httpResponse.statusCode) ?? .unknown))

                case 500...599:
                    completion(.failure(NetworkError(rawValue: httpResponse.statusCode) ?? .serverError))

                default:
                    fatalError("Unhandled HTTP status code: \(httpResponse.statusCode)")
                }
            }
        }.resume()
    }
    
    private func parseJasonForPost (completion: @escaping (Result<NetworkResult, NetworkError>) -> Void) -> (Result<Data, NetworkError>) -> Void {
        return { result in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = JSONDecoder()
                    let object = try jsonDecoder.decode(NetworkResult.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(object))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                     completion(.failure(error))
                 }
            }
        }
    }
    
}



// MARK:- handler

class NetworkHandler {
    
    static func getSource(from serverAddress: String, completion: @escaping ([String]?, Error?) -> ()) {
        var source = [String]()
        
        NetworkAPI().fetchData(from: serverAddress) { result in
            switch result {
            case .success(let response):
                source = response.self
                completion(source, nil)
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
    
    static func postSource(from serverAddress: String, json: [String: String], completion: @escaping (NetworkResult?, Error?) -> ()) {
        
        NetworkAPI().requestPost(from: serverAddress, json: json) { result in
            switch result {
            case .success(let response):
                completion(response.self, nil)
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
    
    
}


struct NetworkResult: Codable {
    let result: String
    let status: String
}
