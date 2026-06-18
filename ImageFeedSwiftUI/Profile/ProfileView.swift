//
//  ProfileView.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 17.06.2026.
//
import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image("Stub")
                Spacer()
                Button {} label: {
                    Image("Exit")
                }
            }
            Text("Екатерина Новикова")
                .font(.system(size: 23, weight: .bold))
                .foregroundStyle(.ypWhite)
                .padding(.top, 8)
            
            Text("@ekaterina_now")
                .font(.system(size: 13))
                .foregroundStyle(.ypGray)
                .padding(.top, 8)
            
            Text("Hello, world!")
                .font(.system(size: 13))
                .foregroundStyle(.ypWhite)
                .padding(.top, 8)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.ypBlack)
    }
}

#Preview {
    ProfileView()
}
