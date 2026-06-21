//
//  PhotosRepositoryProtocol.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 19.06.2026.
//

protocol PhotosRepositoryProtocol {
    func loadNextPage(page: Int) async throws -> [PhotoResponse]
}
