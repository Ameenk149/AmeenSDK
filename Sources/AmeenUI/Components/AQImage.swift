//
//  File.swift
//
//
//  Created by Muhammad Ameen Khalil Qadri on 24.10.24.
//

import Foundation
import SwiftUI
import Kingfisher

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
    public struct AQRemoteImage: View {
        let imageName: String
        var width: CGFloat
        let height: CGFloat
        let isNotForRedaction: Bool
        @State var didFailLoading = false
        
        public init(imageName: String, width: CGFloat = 206, height: CGFloat = 264, isNotForRedaction: Bool = false) {
            self.imageName = imageName
            self.width = width
            self.height = height
            self.isNotForRedaction = isNotForRedaction
        }
        
        public var body: some View {
            let image = URL(string: imageName)
            if didFailLoading {
                if isNotForRedaction {
                    AQ.Components.AQImage(imageName: "sakhiBg", width: 0, height: height)
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .frame(width: width, height: height)
//                            .foregroundStyle(.clear)
//                        AQ.Components.AQSystemImage(systemImage: "photo.on.rectangle.angled", width: 40, height: 40)
//                            
//                    }
                } else {
                    AQ.Components.AQImage(imageName: "sakhiBg", width: width, height: height)
                }
                
            } else {
                KFImage(image)
                    .placeholder {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(width: 50, height: 50)
                    }
                
                    .onFailure { error in
                        didFailLoading = true
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
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
