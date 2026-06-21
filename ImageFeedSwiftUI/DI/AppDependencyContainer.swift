//
//  AppDependencyContainer.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 19.06.2026.
//
import SwiftUI

final class AppDependencyContainer {
    private lazy var networkClient: NetworkClientProtocol = NetworkClient()
    private lazy var photosRepository: PhotosRepositoryProtocol = PhotosRepository(
        networkClient: networkClient
    )
    
    @MainActor
    func makeImageListView() -> some View {
        let interactor = PhotosListInteractor(repository: photosRepository)
        let viewModel = ImageListViewModel(interactor: interactor)
        
        return ImageListView(viewModel: viewModel)
    }
}
