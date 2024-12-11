//
//  LoadingOverlay.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 30.11.24.
//
import SwiftUI

public struct LoadingOverlay: View {
    public var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
        }
    }
}
public struct LoadingModifier: ViewModifier {
    let isLoading: Bool

    public func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading) // Disable interactions while loading
                
            if isLoading {
                LoadingOverlay()
            }
        }
    }
}

extension View {
    public func loadingOverlay(isLoading: Bool) -> some View {
        self.modifier(LoadingModifier(isLoading: isLoading))
    }
}
