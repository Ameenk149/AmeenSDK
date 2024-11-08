//
//  File.swift
//  
//
//  Created by Muhammad Ameen Khalil Qadri on 24.10.24.
//

import Foundation
import SwiftUI

extension AQ.Components {
    public struct AQImage: View {
        let imageName: String
        let width: CGFloat
        let height: CGFloat
        
        public init(imageName: String, width: CGFloat = 206, height: CGFloat = 264) {
            self.imageName = imageName
            self.width = width
            self.height = height
        }
        
        public var body: some View {
            Image(self.imageName)
                .resizable()
                .frame(width: width, height: height)
                .shadow(radius: 10)
        }
    }
    
    public struct AQSystemImage: View {
        let systemImage: String
        let width: CGFloat
        let height: CGFloat
        let imageColor: Color
        
        public init(systemImage: String, width: CGFloat, height: CGFloat, imageColor: Color = .white) {
            self.systemImage = systemImage
            self.width = width
            self.height = height
            self.imageColor = imageColor
        }
        
        public var body: some View {
            Image(systemName: self.systemImage)
                .resizable()
                .foregroundStyle(imageColor)
                .frame(width: width, height: height)
                .shadow(radius: 10)
        }
    }
}
