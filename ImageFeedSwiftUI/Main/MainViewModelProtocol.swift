//
//  MainViewModelProtocol.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 09.07.2026.
//
import Combine

@MainActor
protocol MainViewModelProtocol: ObservableObject {
    var currentState: AppState { get }
    
    func checkKeychain()
    func updateState(to: AppState)
}
