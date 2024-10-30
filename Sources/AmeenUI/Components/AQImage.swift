//
//  File.swift
//  
//
//  Created by Muhammad Ameen Khalil Qadri on 24.10.24.
//

import Foundation
import SwiftUI

extension AQ.Components {
    struct AQImage: View {
        let imageName: String
        let width: CGFloat
        let height: CGFloat
        
        public init(imageName: String, width: CGFloat = 206, height: CGFloat = 264) {
            self.imageName = imageName
            self.width = width
            self.height = height
        }
        
        var body: some View {
            Image(self.imageName)
                .resizable()
                .frame(width: width, height: height)
                .shadow(radius: 10)
        }
    }
    
    struct AQSystemImage: View {
        let systemImage: String
        let width: CGFloat
        let height: CGFloat
        
        public init(systemImage: String, width: CGFloat, height: CGFloat) {
            self.systemImage = systemImage
            self.width = width
            self.height = height
        }
        
        var body: some View {
            Image(systemName: self.systemImage)
                .resizable()
                .frame(width: width, height: height)
                .shadow(radius: 10)
        }
    }
}
