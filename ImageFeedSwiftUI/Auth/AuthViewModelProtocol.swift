//
//  AuthViewModelProtocol.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 08.07.2026.
//
import Foundation
import Combine
import WebKit

@MainActor
protocol AuthViewModelProtocol: ObservableObject {
    var isLoading: Bool { get }
    var alertModel: AlertModel? { get set }
    
    func getAuthURL() -> URL?
    func getCode(from navigationAction: WKNavigationAction) -> Bool
    func getAuthToken(code: String) async
}
