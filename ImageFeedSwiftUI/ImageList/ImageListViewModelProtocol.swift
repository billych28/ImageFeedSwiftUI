//
//  ImageListViewModelProtocol.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 29.06.2026.
//
import Combine

@MainActor
protocol ImageListViewModelProtocol: ObservableObject {
    var photos: [Photo] { get }
    var isLoading: Bool { get }
    var alertModel: AlertModel? { get set }
    
    func loadNextPage() async
}
