//
//  PhotosRepository.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 19.06.2026.
//

final class PhotosService: PhotosServiceProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func loadNextPage(page: Int) async throws -> Result<[Photo], NetworkError> {
        let url = "https://api.unsplash.com/photos?page=\(page)&client_id=Gll7I_bHpQYaaQx03TMwIJoG3CED6zwJGPuvDWavsnc"
        
        let result: Result<[PhotoResponse], NetworkError> = try await networkClient.request(
            url: url
        )
            
        return result.map { photoResponse in
            photoResponse.map {
                $0.toDomain()
            }
        }
    }
}
