//
//  Alert+Binding.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 20.06.2026.
//
import SwiftUI

extension Binding {
    func isPresent<T>() -> Binding<Bool> where Value == T? {
        Binding<Bool>(
            get: { self.wrappedValue != nil },
            set: { newValue in
                if !newValue {
                    self.wrappedValue = nil
                }
            }
        )
    }
}
