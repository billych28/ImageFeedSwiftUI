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
    case decodingError
    case unknown
    
    var title: String {
        switch self {
        case .invalidURL, .invalidResponse:
            "Ошибка соединения"
        default:
            "Ошибка"
        }
    }
        
    var message: String {
        switch self {
        case .invalidURL, .invalidResponse:
            "Произошла ошибка при запросе к серверу"
        case .httpError(let statusCode):
            "Сервер вернул ошибку с кодом: \(statusCode)"
        default:
            "Что-то пошло не так"
        }
    }
}
        
final class NetworkClient: NetworkClientProtocol {
    private let session: URLSession = .shared
    private let decoder = JSONDecoder()
    
    init() {
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func request<T>(request: URLRequest) async throws -> Result<T, NetworkError> where T : Decodable {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(NetworkError.invalidResponse)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                return .failure(
                    NetworkError.httpError(statusCode: httpResponse.statusCode)
                )
            }
            
            do {
                let model = try decoder.decode(T.self, from: data)
                return .success(model)
            } catch {
                return .failure(NetworkError.decodingError)
            }
        }
        catch {
            if error is CancellationError || (error as? URLError)?.code == .cancelled {
                throw error
            }
            
            return .failure(NetworkError.unknown)
        }
    }
}
