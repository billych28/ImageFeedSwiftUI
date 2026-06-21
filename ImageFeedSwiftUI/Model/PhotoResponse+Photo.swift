//
//  PhotoResponse+Photo.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 19.06.2026.
//

extension PhotoResponse {
    func toDomain() -> Photo {
        Photo(
            id: id,
            width: width,
            height: height,
            description: description ?? "",
            smallImageURL: urls.small
        )
    }
}
