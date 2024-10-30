//
//  AQLine.swift
//
//
//  Created by Muhammad Ameen Khalil Qadri on 24.10.24.
//

import SwiftUI

extension AQ.Components.Views {
    public struct AQLine: View {
        let animationValue: String?
        let lineWidth: CGFloat
        
        public init(animationValue: String?, lineWidth: CGFloat = 5) {
            self.animationValue = animationValue
            self.lineWidth = lineWidth
        }
        public var body: some View {
            Rectangle()
                .foregroundStyle(.white)
                .frame( width: lineWidth, height: 2)
                .cornerRadius(10)
                .shadow(radius: 10)
                .transition(.opacity.combined(with: .scale)) // Animate opacity and scale
                .animation(.easeInOut(duration: 0.3), value: animationValue)
        }
    }
}

    
