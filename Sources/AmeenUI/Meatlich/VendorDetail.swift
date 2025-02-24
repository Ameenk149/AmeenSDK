//
//  AQBigImageAndTextView.swift
//
//
//  Created by Muhammad Ameen Khalil Qadri on 16.10.24.
//

import SwiftUI
import Kingfisher

extension AQ.Meatlich {
    public struct VendorDetail: View {
        
        let title: String
        let description: String
        let tagText: String?
        let imageName: String
        let height: CGFloat
        let width: CGFloat
        
        public init(
            title: String,
            description: String,
            tagText: String?,
            imageName: String,
            height: CGFloat = 400,
            width: CGFloat = 350
        ) {
            self.title = title
            self.description = description
            self.tagText = tagText
            self.imageName = imageName
            self.height = height
            self.width = width
        }
        public var body: some View {
            VStack(alignment: .leading) {
                
                AQ.Components.AQRemoteImage(imageName: imageName, width: width, height: height)
                
                HStack {
                    Text(title)
                        .font(AmeenUIConfig.shared.appFont.bigTitleBold())
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .padding(.vertical)
                    Spacer()
                    if let tagText = tagText {
                        Text(tagText)
                            .font(AmeenUIConfig.shared.appFont.bigTitleBold())
                            .padding(8)
                            .padding(.horizontal)
                            .background(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                    }
                }
                
                
                // Description Section
                Text(description)
                    .multilineTextAlignment(.leading)
                    .font(AmeenUIConfig.shared.appFont.subtitleMedium())
                    .padding(.vertical, 2)
                    .padding(.trailing)
                    .foregroundColor(AmeenUIConfig.shared.colorPalette.fontSecondaryColor)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(width: width)
        }
    }
}
