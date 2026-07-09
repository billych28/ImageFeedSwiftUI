//
//  AuthView.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 08.07.2026.
//
import SwiftUI
import WebKit

struct AuthView<ViewModel>: View where ViewModel: AuthViewModelProtocol {
    @ObservedObject var viewModel: ViewModel
    
    @State private var isShowingWebView = false
    
    var body: some View {
        container {
            content
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView()
                .tint(.ypWhite)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            Image(.unsplashLogo)
        }
    }
    
    private var loginButton: some View {
        Button {
            isShowingWebView = true
        } label: {
            Text("Войти")
                .foregroundStyle(.ypBlack)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(.ypWhite)
                .cornerRadius(16)
        }
        .padding(.horizontal, 16)
    }
    
    private var webView: some View {
        WebView(url: viewModel.getAuthURL()) { action in
            if viewModel.getCode(from: action) {
                isShowingWebView = false
                return true
            }
            return false
        }
    }
    
    private func container(@ViewBuilder content: () -> some View) -> some View {
        VStack {
            content()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ypBlack)
        .safeAreaInset(edge: .bottom, content: {
            if !viewModel.isLoading {
                loginButton
            }
        })
        .sheet(isPresented: $isShowingWebView) {
            webView
        }
        .alert(
            viewModel.alertModel?.title ?? "Ошибка",
            isPresented: $viewModel.alertModel.isPresent(),
            presenting: viewModel.alertModel
        ) { _ in
            Button("Ок", role: .cancel) {}
        } message: { alert in
            Text(alert.message)
        }
    }
}
