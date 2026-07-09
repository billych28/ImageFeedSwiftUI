//
//  AuthService.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 08.07.2026.
//
import Foundation

private enum Constants {
    static let authorizeURLString = "https://unsplash.com/oauth/authorize"
    static let getTokenURLString = "https://unsplash.com/oauth/token"
}

final class AuthService: AuthServiceProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func getAuthURL() -> URL? {
        guard var urlComponents = URLComponents(string: Constants.authorizeURLString) else {
            return nil
        }
            
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: GlobalConstants.accessKey),
            URLQueryItem(
                name: "redirect_uri",
                value: GlobalConstants.redirectURI
            ),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: GlobalConstants.accessScope)
        ]
            
        return urlComponents.url
    }
    
    func fetchAuthToken(code: String) async throws -> Result<OAuthTokenResponse, NetworkError> {
        guard let request = makeOAuthTokenRequest(code: code) else {
            return .failure(.invalidURL)
        }
        
        let result: Result<OAuthTokenResponse, NetworkError> = try await networkClient.request(request: request)
        
        return result
    }
    
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: Constants.getTokenURLString) else {
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: GlobalConstants.accessKey),
            URLQueryItem(
                name: "client_secret",
                value: GlobalConstants.secretKey
            ),
            URLQueryItem(
                name: "redirect_uri",
                value: GlobalConstants.redirectURI
            ),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
        ]
        
        guard let authTokenUrl = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: authTokenUrl)
        request.httpMethod = "POST"
        return request
    }
}
