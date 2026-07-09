//
//  AppDependencyContainer.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 19.06.2026.
//
import SwiftUI

@MainActor
protocol AppDependencyContainerProtocol {
    func makeAuthView() -> AnyView
    func makeImageListView() -> AnyView
    func makeProfileView() -> AnyView
}

final class AppDependencyContainer {
    private lazy var networkClient: NetworkClientProtocol = NetworkClient()
    private lazy var photosService: PhotosServiceProtocol = PhotosService(networkClient: networkClient)
    private lazy var authService: AuthServiceProtocol = AuthService(networkClient: networkClient)
    private lazy var storageService: StorageServiceProtocol = StorageService()
    
    lazy var mainViewModel = MainViewModel(storageService: storageService)
    
    private lazy var authViewModel = AuthViewModel(
        service: authService,
        storageService: storageService,
        onLoginSuccess: { [weak self] in
            guard let self else { return }
            mainViewModel.updateState(to: .authenticated)
        }
    )
    private lazy var imageListViewModel = ImageListViewModel(
        service: photosService
    )
    
    @MainActor
    func makeMainView() -> some View {
        MainView(viewModel: mainViewModel, container: self)
    }
    
    @MainActor
    fileprivate func buildAuthView() -> some View {
        AuthView(viewModel: authViewModel)
    }
    
    @MainActor
    fileprivate func buildImageListView() -> some View {
        ImageListView(viewModel: imageListViewModel)
    }
    
    @MainActor
    fileprivate func buildProfileView() -> some View {
        ProfileView()
    }
}

extension AppDependencyContainer: AppDependencyContainerProtocol {
    func makeAuthView() -> AnyView {
        AnyView(self.buildAuthView())
    }
    
    func makeImageListView() -> AnyView {
        AnyView(self.buildImageListView())
    }
    
    func makeProfileView() -> AnyView {
        AnyView(self.buildProfileView())
    }
}
