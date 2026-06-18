//
//  CardView.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 17.06.2026.
//
import SwiftUI

struct ImageModel: Identifiable {
    let id = UUID()
    
    let imageName: String
    let subtitle: String
}

struct CardView: View {
    var image: ImageModel
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(image.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)

            LinearGradient(
                colors: [.clear, .black.opacity(0.5)],
                startPoint: .top,
                endPoint: .bottom
            ).overlay {
                
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Image("Like Inactive")
                    }
                }
                Spacer()
            }
            .padding(16)
            
            Text(image.subtitle)
                .foregroundStyle(.white)
                .padding(.leading, 8)
                .padding(.bottom, 8)
        }
        .fixedSize(horizontal: false, vertical: true)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CardView(image: ImageModel(imageName: "0", subtitle: "Subtitle"))
}
