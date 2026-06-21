//
//  PhotoResponse+Photo.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 19.06.2026.
//

extension PhotoResponse {
    func toDomain() -> Photo {
        Photo(
            id: self.id,
            width: self.width,
            height: self.height,
            description: self.description ?? "",
            smallImageURL: self.urls.small
        )
    }
}
