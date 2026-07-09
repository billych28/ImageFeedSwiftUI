//
//  MainViewModel.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 09.07.2026.
//
import Combine

enum AppState {
    case checkingToken
    case unauthenticated
    case authenticated
}

@MainActor
final class MainViewModel: MainViewModelProtocol {
    @Published private(set) var currentState: AppState = .checkingToken
    private var storageService: StorageServiceProtocol
    
    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }
    
    func checkKeychain() {
        let hasToken = storageService.token != nil
        currentState = hasToken ? .authenticated : .unauthenticated
    }
    
    func updateState(to state: AppState) {
        currentState = state
    }
}
