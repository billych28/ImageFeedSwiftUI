//
//  PhotosResponse.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 18.06.2026.
//

import Foundation

struct PhotoResponse: Codable {
    let id: String
    let width: Int
    let height: Int
    let description: String?
    let urls: PhotoUrlResponse
}

struct PhotoUrlResponse: Codable {
    let small: String
}
