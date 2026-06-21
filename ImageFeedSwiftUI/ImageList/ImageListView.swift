//
//  ImageListView.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 17.06.2026.
//
import SwiftUI

struct ImageListView<ViewModel>: View where ViewModel: ImageListViewModelProtocol {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        container {
            content
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.photos.isEmpty {
            loadingView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            listView
        }
    }
    
    private var loadingView: some View {
        ProgressView()
            .tint(.ypWhite)
    }
    
    private var listView: some View {
        List {
            ForEach(viewModel.photos) { photo in
                CardView(photo: photo)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .task {
                        if photo.id == viewModel.photos.last?.id {
                            await viewModel.loadNextPage()
                        }
                    }
            }
            
            if viewModel.isLoading {
                loadingView
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity)
            }
        }
        .listStyle(.plain)
    }
    
    private func container(@ViewBuilder content: () -> some View) -> some View {
        Group {
            content()
        }
        .background(.ypBlack)
        .alert(
            viewModel.alertModel?.title ?? "Ошибка",
            isPresented: $viewModel.alertModel.isPresent(),
            presenting: viewModel.alertModel
        ) { _ in
            Button("Ок", role: .cancel) {}
        } message: { alert in
            Text(alert.message)
        }
        .task {
            if viewModel.photos.isEmpty {
                await viewModel.loadNextPage()
            }
        }
    }
}

#Preview {
    let service = MockPhotosService()
    let viewModel = ImageListViewModel(service: service)
    
    ImageListView(viewModel: viewModel)
}

private final class MockPhotosService: PhotosServiceProtocol {
    func loadNextPage(page: Int) async -> Result<[Photo], NetworkError> {
        return .success(
            [
                Photo(
                    id: "1",
                    width: 1280,
                    height: 720,
                    description: "Description",
                    smallImageURL: ""
                ),
                Photo(
                    id: "2",
                    width: 1280,
                    height: 720,
                    description: "Description",
                    smallImageURL: ""
                ),
            ]
        )
    }
}
