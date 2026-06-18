//
//  ImageListView.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 17.06.2026.
//
import SwiftUI

struct ImageListView: View {
    private let images: [ImageModel] = [
        ImageModel(imageName: "0", subtitle: "Lorem ipsum"),
        ImageModel(imageName: "1", subtitle: "Bottom text"),
        ImageModel(imageName: "2", subtitle: "Большая картинка"),
        ImageModel(imageName: "3", subtitle: "Bla bla"),
        ImageModel(imageName: "4", subtitle: "Test"),
        ImageModel(imageName: "5", subtitle: "123"),
        ImageModel(imageName: "6", subtitle: "321"),
    ]
    
    var body: some View {
        List(images) { image in
            CardView(image: image)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(.ypBlack)
    }
}

#Preview {
    ImageListView()
}
