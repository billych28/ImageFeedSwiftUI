//
//  AppDependencyContainer.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 19.06.2026.
//
import SwiftUI

final class AppDependencyContainer {
    private lazy var networkClient: NetworkClientProtocol = NetworkClient()
    private lazy var photosService: PhotosServiceProtocol = PhotosService(
        networkClient: networkClient
    )
    private lazy var imageListViewModel = ImageListViewModel(
        service: photosService
    )
    
    @MainActor
    func makeImageListView() -> some View {
        ImageListView(viewModel: imageListViewModel)
    }
}
