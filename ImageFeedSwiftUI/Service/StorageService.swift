//
//  StorageService.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 08.07.2026.
//
import KeychainSwift

private enum KeychainKeys: String {
    case token
}

final class StorageService: StorageServiceProtocol {
    var token: String? {
        get {
            keychain.get(KeychainKeys.token.rawValue)
        }
        set {
            if let token = newValue {
                keychain.set(token, forKey: KeychainKeys.token.rawValue)
            } else {
                keychain.delete(KeychainKeys.token.rawValue)
            }
        }
    }
    
    private let keychain = KeychainSwift()
}
