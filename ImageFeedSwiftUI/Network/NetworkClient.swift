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
    case cancelled(Error)
    
    var errorDescription: String? {
        return switch self {
        case .invalidURL, .invalidResponse, .httpError:
            "Нет соединения с интернетом\n Попробуйте обновить позднее или проверить подключение сети"
        case .unknown:
            "Произошла ошибка при выполнении операции"
        default:
            nil
        }
    }
        
    var debugDescription: String? {
        switch self {
        case .invalidURL:
            "Отсутствует URL"
        case .invalidResponse:
            "Запрос выполнен без ошибки, но в параметрах замыкания отсутствует `URLResponse` или он не является `HTTPURLResponse`"
        case .httpError(let code):
            "Сервер вернул ответ с кодом ошибки: \(code)"
        case .decodingError(let error):
            error.localizedDescription
        case .unknown(let error), .cancelled(let error):
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
    
    func request<T>(url: String) async -> Result<T, NetworkError> where T : Decodable {
        guard let url = URL(string: url) else {
            let error = NetworkError.invalidURL
            print(String(describing: error.debugDescription))
            return .failure(error)
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NetworkError.invalidResponse
                print(String(describing: error.debugDescription))
                return .failure(error)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let error = NetworkError.httpError(
                    statusCode: httpResponse.statusCode
                )
                print(String(describing: error.debugDescription))
                return .failure(error)
            }
            
            do {
                let model = try decoder.decode(T.self, from: data)
                return .success(model)
            } catch {
                let error = NetworkError.decodingError(error)
                print(String(describing: error.debugDescription))
                return .failure(error)
            }
        }
        catch {
            if error is CancellationError || (error as? URLError)?.code == .cancelled {
                return .failure(.cancelled(error))
            }
            
            return .failure(.unknown(error))
        }
    }
}
