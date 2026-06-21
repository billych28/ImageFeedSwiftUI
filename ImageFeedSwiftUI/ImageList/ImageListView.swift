//
//  ImageListView.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 17.06.2026.
//
import SwiftUI

struct ImageListView: View {
    @State private var viewModel: ImageListViewModel
    
    init(viewModel: ImageListViewModel) {
        self.viewModel = viewModel
    }
    
    private var loadingView: some View {
        ProgressView()
            .tint(.ypWhite)
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading && viewModel.photos.isEmpty {
                loadingView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
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
                .scrollContentBackground(.hidden)
            }
        }
        .background(.ypBlack)
        .alert(
            viewModel.errorAlert?.title ?? "",
            isPresented: $viewModel.errorAlert.isPresent(),
            presenting: viewModel.errorAlert
        ) { _ in
            Button("Ок", role: .cancel) {}
        } message: { error in
            Text(error.message)
        }
        .task {
            if viewModel.photos.isEmpty {
                await viewModel.loadNextPage()
            }
        }
    }
}

#Preview {
    let interactor = PhotosListInteractor(repository: MockPhotosRepository())
    let viewModel = ImageListViewModel(interactor: interactor)
    
    ImageListView(viewModel: viewModel)
}

class MockPhotosRepository: PhotosRepositoryProtocol {
    func loadNextPage(page: Int) async throws -> [PhotoResponse] {
        return [
            PhotoResponse(
                id: "1",
                width: 1280,
                height: 720,
                description: "Description",
                urls: PhotoUrlResponse(small: "")
            ),
            PhotoResponse(
                id: "2",
                width: 1280,
                height: 720,
                description: "Description",
                urls: PhotoUrlResponse(small: "")
            ),
        ]
    }
}
