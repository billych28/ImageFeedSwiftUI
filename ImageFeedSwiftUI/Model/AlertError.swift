//
//  AlertError.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 19.06.2026.
//
import Foundation

struct AlertError: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    
    init(from error: Error) {
        if let networkError = error as? NetworkError {
            switch networkError {
            case .invalidURL, .invalidResponse:
                self.title = "Ошибка соединения"
                self.message = "Произошла ошибка при запросе к серверу"
            case .httpError(let statusCode):
                self.title = "Ошибка"
                self.message = "Сервер вернул ошибку c кодом: \(statusCode)"
            case .decodingError:
                self.title = "Ошибка данных"
                self.message = "Произошла ошибка при обработке данных с сервера"
            case .unknown:
                self.title = "Ошибка"
                self.message = "Что-то пошло не так"
            }
        } else {
            self.title = "Ошибка"
            self.message = "Что-то пошло не так"
        }
    }
}
