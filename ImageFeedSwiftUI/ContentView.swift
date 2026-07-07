//
//  ContentView.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 15.06.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    private let container: AppDependencyContainer
    private let imagesTabTag = 0
    private let profileTabTag = 1
    private var imagesTabImage: String {
        selectedTab == 0 ? "Images Tab Active" : "Images Tab Inactive"
    }
    private var profileTabImage: String {
        selectedTab == 1 ? "Profile Tab Active" : "Profile Tab Inactive"
    }
    
    init(container: AppDependencyContainer, selectedTab: Int = 0) {
        self.container = container
        self.selectedTab = selectedTab
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            container.makeImageListView()
                .tabItem {
                    Image(imagesTabImage)
                }
                .tag(imagesTabTag)
            
            ProfileView()
                .tabItem {
                    Image(profileTabImage)
                }
                .tag(profileTabTag)
        }
    }
}

#Preview {
    let container = AppDependencyContainer()
    ContentView(container: container)
}
