//
//  NetworkClient.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 19.06.2026.
//
import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(Error)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "Invalid URL"
        case .invalidResponse:
            "Received an invalid response from server"
        case .httpError(let code):
            "Server returned an HTTP error code: \(code)"
        case .decodingError:
            "Failed to map the server data to the local model"
        case .unknown(let error):
            error.localizedDescription
        }
    }
}

final class NetworkClient: NetworkClientProtocol {
    private let session: URLSession = .shared
    private let decoder = JSONDecoder()
    
    init() {
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func request<T>(url: String) async throws -> T where T : Decodable {
        guard let url = URL(string: url) else {
            let error = NetworkError.invalidURL
            print(String(describing: error.localizedDescription))
            throw NetworkError.invalidURL
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NetworkError.invalidResponse
                print(String(describing: error.localizedDescription))
                throw error
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let error = NetworkError.httpError(
                    statusCode: httpResponse.statusCode
                )
                print(String(describing: error.localizedDescription))
                throw error
            }
            
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                let error = NetworkError.decodingError(error)
                print(String(describing: error.localizedDescription))
                throw error
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            print("Unknown error occured: \(error.localizedDescription)")
            throw NetworkError.unknown(error)
        }
    }
}
