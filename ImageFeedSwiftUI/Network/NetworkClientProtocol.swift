//
//  NetworkClientProtocol.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 19.06.2026.
//
import Foundation

protocol NetworkClientProtocol {
    func request<T: Decodable>(url: String) async throws -> Result<T, NetworkError>
}
