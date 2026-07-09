//
//  ContentView.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 15.06.2026.
//

import SwiftUI
import Combine

struct MainView<ViewModel>: View where ViewModel: MainViewModelProtocol {
    @State private var selectedTab = 0
    @ObservedObject private var viewModel: ViewModel
    
    private let container: AppDependencyContainerProtocol
    private let imagesTabTag = 0
    private let profileTabTag = 1
    private var imagesTabImage: ImageResource {
        selectedTab == 0 ? .imagesTabActive : .imagesTabInactive
    }
    private var profileTabImage: ImageResource {
        selectedTab == 1 ? .profileTabActive : .profileTabInactive
    }
    
    init(viewModel: ViewModel, container: AppDependencyContainerProtocol) {
        self.viewModel = viewModel
        self.container = container
    }
    
    var body: some View {
        Group {
            switch viewModel.currentState {
            case .checkingToken:
                ProgressView()
            case .unauthenticated:
                container.makeAuthView()
            case .authenticated:
                mainTabView
            }
        }
        .task {
            viewModel.checkKeychain()
        }
    }
    
    private var mainTabView: some View {
        TabView(selection: $selectedTab) {
            container.makeImageListView()
                .tabItem {
                    Image(imagesTabImage)
                }
                .tag(imagesTabTag)
        
            container.makeProfileView()
                .tabItem {
                    Image(profileTabImage)
                }
                .tag(profileTabTag)
        }
    }
}
