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
    
    private var imagesTabImage: String {
        selectedTab == 0 ? "Images Tab Active" : "Images Tab Inactive"
    }
    
    private var profileTabImage: String {
        selectedTab == 1 ? "Profile Tab Active" : "Profile Tab Inactive"
    }
    
    init(container: AppDependencyContainer, selectedTab: Int = 0, ) {
        self.selectedTab = selectedTab
        self.container = container
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("", image: imagesTabImage, value: 0) {
                container.makeImageListView()
            }
            
            Tab("", image: profileTabImage, value: 1) {
                ProfileView()
            }
        }
    }
}

#Preview {
    let container = AppDependencyContainer()
    ContentView(container: container)
}
