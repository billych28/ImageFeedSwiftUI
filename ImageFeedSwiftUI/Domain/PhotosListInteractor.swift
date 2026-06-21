//
//  PhotosListUseCase.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 19.06.2026.
//

final class PhotosListInteractor {
    private let repository: PhotosRepositoryProtocol
    
    init(repository: PhotosRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(page: Int) async throws -> [Photo] {
        try await repository.loadNextPage(page: page).map {
            $0.toDomain()
        }
    }
}
