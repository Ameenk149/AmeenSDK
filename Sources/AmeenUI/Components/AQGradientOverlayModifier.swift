//
//  GradientOverlayModifier.swift
//  
//
//  Created by Muhammad Ameen Khalil Qadri on 24.10.24.
//

import SwiftUI

extension AQ.Components {
    struct AQGradientBackgroundModifier: ViewModifier {
        var colors: [Color] // Array of colors for the gradient
        var startPoint: UnitPoint // Gradient start point
        var endPoint: UnitPoint // Gradient end point
        var blurRadius: CGFloat // Blur effect for overlay
        var cornerRadius: CGFloat // Corner radius for overlay
        
        func body(content: Content) -> some View {
            content
                .background(
                    LinearGradient(gradient: Gradient(colors: colors),
                                   startPoint: startPoint,
                                   endPoint: endPoint)
                    .blur(radius: blurRadius) // Apply blur if desired
                        .cornerRadius(cornerRadius) // Apply corner radius if desired
                )
        }
    }
}

// Custom API to easily apply gradient overlay
extension View {
    func AQGradientBackground(
        colors: [Color] = [Color.white.opacity(0.1), Color.black.opacity(0.8)],
        startPoint: UnitPoint = .top,
        endPoint: UnitPoint = .bottom,
        blurRadius: CGFloat = 5,
        cornerRadius: CGFloat = 15
    ) -> some View {
        self.modifier(AQ.Components.AQGradientBackgroundModifier(
            colors: colors,
            startPoint: startPoint,
            endPoint: endPoint,
            blurRadius: blurRadius,
            cornerRadius: cornerRadius
        ))
    }
}
