//
//  AuthViewModel.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 08.07.2026.
//

import SwiftUI
import Combine
import WebKit

private enum Constants {
    static let successAuthorizationURLPath = "/oauth/authorize/native"
    static let queryItemCodeName = "code"
}

@MainActor
final class AuthViewModel: AuthViewModelProtocol, AlertErrorHandler {
    @Published var isLoading = false
    @Published var alertModel: AlertModel?
    
    private var service: AuthServiceProtocol
    private var storageService: StorageServiceProtocol
    private let onSuccessLogin: () -> Void
    
    init(
        service: AuthServiceProtocol,
        storageService: StorageServiceProtocol,
        onLoginSuccess: @escaping () -> Void,
    ) {
        self.service = service
        self.storageService = storageService
        self.onSuccessLogin = onLoginSuccess
    }
    
    func getAuthURL() -> URL? {
        service.getAuthURL()
    }
    
    func getCode(from navigationAction: WKNavigationAction) -> Bool {
        if
            let url = navigationAction.request.url,
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == Constants.successAuthorizationURLPath,
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == Constants.queryItemCodeName }),
            let code = codeItem.value
        {
            getAuthToken(code: code)
            return true
        } else {
            return false
        }
    }
    
    func getAuthToken(code: String) {
        guard !isLoading else { return }
        
        isLoading = true
        
        Task { [weak self] in
            guard let self else { return }
            
            defer { isLoading = false }
            
            do {
                let result = try await service.fetchAuthToken(code: code)
                
                switch result {
                case .success(let body):
                    storageService.token = body.accessToken
                    onSuccessLogin()
                case .failure(let error):
                    self.alertModel = getAlertModel(error: error)
                }
            } catch {
                print("Cancellation")
            }
        }
    }
}
