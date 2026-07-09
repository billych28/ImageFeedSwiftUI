//
//  PhotosRepository.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 19.06.2026.
//
import Foundation

final class PhotosService: PhotosServiceProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func loadNextPage(page: Int) async throws -> Result<[Photo], NetworkError> {
        guard let url = URL(string: "https://api.unsplash.com/photos?page=\(page)&client_id=Gll7I_bHpQYaaQx03TMwIJoG3CED6zwJGPuvDWavsnc") else {
            return .failure(.invalidURL)
        }
        let request = URLRequest(url: url)
        
        let result: Result<[PhotoResponse], NetworkError> = try await networkClient.request(
            request: request
        )
            
        return result.map { photoResponse in
            photoResponse.map {
                $0.toDomain()
            }
        }
    }
}
