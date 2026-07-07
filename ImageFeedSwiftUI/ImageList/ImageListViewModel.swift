//
//  ImageListViewModel.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 18.06.2026.
//
import SwiftUI
import Combine

@MainActor
class ImageListViewModel: ImageListViewModelProtocol {
    @Published var photos: [Photo] = []
    @Published var isLoading: Bool = false
    @Published var alertModel: AlertModel?
    
    private let service: PhotosServiceProtocol
    private var currentPage = 1
    
    init(service: PhotosServiceProtocol) {
        self.service = service
    }
    
    func loadNextPage() async {
        guard !isLoading else { return }
        
        isLoading = true
        
        do {
            let result = try await service.loadNextPage(page: currentPage)
            
            switch result {
            case .success(let photos):
                self.photos.append(contentsOf: photos)
                self.currentPage += 1
            case .failure(let error):
                self.alertModel = getAlertModel(error: error)
            }
        } catch {
            print("Cancellation")
        }
        
        isLoading = false
    }
    
    private func getAlertModel(error: NetworkError) -> AlertModel {
        AlertModel(title: "Ошибка", message: error.localizedDescription)
    }
}
