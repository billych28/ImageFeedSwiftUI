//
//  CardView.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 17.06.2026.
//
import SwiftUI
import Kingfisher

struct CardView: View {
    var photo: Photo
    
    private var aspectRatio: CGFloat {
        guard photo.width > 0, photo.height > 0 else { return 1 }
        return CGFloat(photo.width) / CGFloat(photo.height)
    }
    
    var body: some View {
        container {
            imageView
            textView
        }
    }
    
    private func container(@ViewBuilder content: () -> some View) -> some View {
        ZStack(alignment: .bottomLeading) {
            content()
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
    }
    
    private var imageView: some View {
        ZStack(alignment: .topTrailing) {
            KFImage(URL(string: photo.smallImageURL))
                .placeholder {
                    Image(.imageStub)
                        .resizable()
                        .scaledToFill()
                }
                .resizable()
                .aspectRatio(aspectRatio, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Button(action: {}) {
                Image(.likeInactive)
            }
            .padding(16)
        }
    }
    
    private var textView: some View {
        Text(photo.description)
            .lineLimit(1)
            .font(.system(size: 13))
            .foregroundStyle(.ypWhite)
            .padding(.leading, 16)
            .padding(.bottom, 8)
            .background {
                LinearGradient(
                    colors: [.clear, .black.opacity(0.1)],
                    startPoint: .bottomLeading,
                    endPoint: .bottomTrailing
                )
            }
    }
}

#Preview {
    CardView(
        photo: Photo(
            id: "id",
            width: 1280,
            height: 720,
            description: "Description",
            smallImageURL: "https://images.unsplash.com/photo-1493612276216-ee3925520721?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmFuZG9tfGVufDB8fDB8fHww"
        )
    )
}
