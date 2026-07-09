//
//  AuthServiceProtocol.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 08.07.2026.
//
import Foundation

protocol AuthServiceProtocol {
    func getAuthURL() -> URL?
    func fetchAuthToken(code: String) async throws -> Result<OAuthTokenResponse, NetworkError>
}
