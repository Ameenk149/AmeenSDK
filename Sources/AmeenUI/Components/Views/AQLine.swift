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
        let color: Color
        
        public init(animationValue: String?, lineWidth: CGFloat = 5, color: Color = .white) {
            self.animationValue = animationValue
            self.lineWidth = lineWidth
            self.color = color
        }
        public var body: some View {
            Rectangle()
                .foregroundStyle(color)
                .frame(width: lineWidth, height: 2)
                .cornerRadius(10)
                .shadow(radius: 10)
                .transition(.opacity.combined(with: .scale)) // Animate opacity and scale
                .animation(.easeInOut(duration: 0.3), value: animationValue)
        }
    }
    public struct AQDottedLine: View {
        let animationValue: String?
        let lineWidth: CGFloat
        let color: Color
        let isDotted: Bool // Add support for dotted lines
        
        public init(animationValue: String?, lineWidth: CGFloat = 5, color: Color = .white, isDotted: Bool = false) {
            self.animationValue = animationValue
            self.lineWidth = lineWidth
            self.color = color
            self.isDotted = isDotted
        }
        
        public var body: some View {
            GeometryReader { geometry in
                Path { path in
                    path.move(to: CGPoint(x: 0, y: geometry.size.height / 2))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height / 2))
                }
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round,
                        lineJoin: .round,
                        dash: isDotted ? [5, 10] : [] // Use dashed style for dotted lines
                    )
                )
                .cornerRadius(10)
                .shadow(radius: 10)
                .transition(.opacity.combined(with: .scale)) // Animate opacity and scale
                .animation(.easeInOut(duration: 0.3), value: animationValue)
            }
            .frame(width: lineWidth, height: 2)
        }
    }
}

    
