//
//  NetworkAPI.swift
//  SignUpApp
//
//  Created by Lia on 2021/04/01.
//

import Foundation

class NetworkAPI {
    
    typealias ExistID = [String]
    
    // MARK: 1. Session 생성
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    enum NetworkError: Int, Error {
        case badURL
        case requestFailure
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
    }
    
    
    func fetchData(from urlString: String, completion: @escaping (Result<ExistID, NetworkError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        // MARK: 2. Request
        let request = URLRequest(url: url) // default: GET
        
        performTask(request: request, completion: parseJason(completion: completion))
    }
    
    // error 처리
    private func performTask(request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        // MARK: 3. DataTask
        session.dataTask(with: request) { data, response, error in

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.badRequest))
                return
            }
            DispatchQueue.main.async {
                if let data = data {
                    completion(.success(data))
                } else if error != nil {
                    completion(.failure(NetworkError.init(rawValue: httpResponse.statusCode) ?? .requestFailure))
                } else {
                    completion(.failure(.unknown))
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
}

