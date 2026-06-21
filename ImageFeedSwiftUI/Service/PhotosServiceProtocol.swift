//
//  PhotosRepositoryProtocol.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 19.06.2026.
//

protocol PhotosServiceProtocol {
    func loadNextPage(page: Int) async -> Result<[Photo], NetworkError>
}
