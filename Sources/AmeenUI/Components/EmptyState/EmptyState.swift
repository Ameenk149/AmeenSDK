//
//  EmptyState.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 09.11.24.
//
import SwiftUI

extension AQ.Components {
    public static func EmptyStateView<Content: View>(
        isActiveSymbol: Binding<Bool> = .constant(false),
        iconName: String = "rectangle.stack.badge.minus",
        titleText: String = "No products posted",
        messageText: String = "Your posted products will appear here",
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack {
            Spacer().frame(height: 250)
            
            Image(systemName: iconName)
                .resizable()
                .frame(width: 60, height: 50)
                .foregroundStyle(.white)
                .symbolEffect(.pulse.byLayer, isActive: isActiveSymbol.wrappedValue)
            
            VStack(spacing: 10) {
                AQ.Components.AQText(text: titleText, fontSize: 16)
                AQ.Components.AQText(text: messageText, fontSize: 12)
            }
            .padding()
            
            content()
        }
        .onAppear { isActiveSymbol.wrappedValue = true }
    }
}
