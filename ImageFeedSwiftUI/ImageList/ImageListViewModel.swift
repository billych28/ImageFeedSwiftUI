//
//  ImageListViewModel.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 18.06.2026.
//
import SwiftUI

@MainActor
@Observable
class ImageListViewModel {
    var photos: [Photo] = []
    var isLoading: Bool = false
    var errorAlert: AlertError?
    
    private let interactor: PhotosListInteractor
    private var currentPage = 1
    
    init(
        interactor: PhotosListInteractor,
        currentPage: Int = 1,
        isLoading: Bool = false
    ) {
        self.interactor = interactor
        self.currentPage = currentPage
        self.isLoading = isLoading
    }
    
    func loadNextPage() async {
        guard !isLoading else { return }
        
        isLoading = true
        
        do {
            let photos = try await interactor.execute(
                page: currentPage
            )
            self.photos.append(contentsOf: photos)
            self.currentPage += 1
        } catch {
            self.errorAlert = .init(from: error)
        }
        
        isLoading = false
    }
}
