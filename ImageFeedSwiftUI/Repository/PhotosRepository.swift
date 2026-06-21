//
//  PhotosRepository.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 19.06.2026.
//

final class PhotosRepository: PhotosRepositoryProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func loadNextPage(page: Int) async throws -> [PhotoResponse] {
        let url = "https://api.unsplash.com/photos?page=\(page)&client_id=Gll7I_bHpQYaaQx03TMwIJoG3CED6zwJGPuvDWavsnc"
        return try await networkClient.request(url: url)
    }
}
