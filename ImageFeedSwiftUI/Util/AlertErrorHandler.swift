//
//  AlertErrorHandler.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 09.07.2026.
//
import Foundation

protocol AlertErrorHandler {
    func getAlertModel(error: NetworkError) -> AlertModel
}

extension AlertErrorHandler {
    func getAlertModel(error: NetworkError) -> AlertModel {
        AlertModel(title: "Ошибка", message: error.localizedDescription)
    }
}
