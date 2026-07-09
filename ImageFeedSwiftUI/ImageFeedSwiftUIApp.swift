//
//  ImageFeedSwiftUIApp.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 15.06.2026.
//

import SwiftUI

@main
struct ImageFeedSwiftUIApp: App {
    private let container = AppDependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            container.makeMainView()
        }
    }
}
