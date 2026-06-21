//
//  PhotosResponse.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 18.06.2026.
//

import Foundation

struct PhotoResponse: Decodable {
    let id: String
    let width: Int
    let height: Int
    let description: String?
    let urls: PhotoUrlResponse
}

struct PhotoUrlResponse: Decodable {
    let small: String
}
