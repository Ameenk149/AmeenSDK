//
//  File.swift
//  
//
//  Created by Muhammad Ameen Khalil Qadri on 24.10.24.
//

import Foundation
import SwiftUI

extension AQ.Meatlich {
    public struct CellView_BigImageWithButtonTopRightAndLabelDown: View {
        var imageName: String
        var buttonImage: String
        var action: () -> ()
        
        public init(imageName: String, buttonImage: String, action:@escaping ()->()) {
            self.imageName = imageName
            self.buttonImage = buttonImage
            self.action = action
        }
        
        public var body: some View {
            ZStack {
                AQ.Components.AQImage(imageName: imageName)
                    .cornerRadius(10)
                VStack {
                    HStack {
                        Spacer()
                        AQ.Components.AQImageButtonCustomImage(image: buttonImage, action: {
                            action()
                        })
                    }
                    Spacer()
                    HStack {
                        AQ.Components.AQText(text: "Chicken Brust", fontSize: 18)
                            .padding()
                        Spacer()
                    }
                    .AQGradientBackground()
                }
            }
        }
    }
    
    public struct CellView_HorizontalWithImageAndButton: View {
        let imageName: String
        let buttonImage: String
        let title: String
        let description: String
        let width: CGFloat
        let height: CGFloat
        let action: () -> ()
        
        public init(
            imageName: String,
            buttonImage: String,
            title: String,
            description: String,
            width: CGFloat = 100,
            height: CGFloat = 100,
            action: @escaping () -> ()
        ) {
            self.imageName = imageName
            self.buttonImage = buttonImage
            self.title = title
            self.description = description
            self.height = height
            self.width = width
            self.action = action
        }
        
        public var body: some View {
            ZStack {
                AmeenUIConfig.shared.colorPalette.secondaryColor
                HStack {
                    AQ.Components.AQImage(imageName: imageName, width: width, height: height)
                    Spacer()
                    VStack(alignment: .leading, spacing: 5) {
                        AQ.Components.AQText(
                            text: title,
                            font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 16))
                        
                        AQ.Components.AQText(
                            text: description,
                            fontSize: 12
                        )
                    }
                    Spacer()
                    AQ.Components.AQImageButtonCustomImage(image: buttonImage) {
                        action()
                    }
                    Spacer()
                }
            }
            .cornerRadius(10)
        }
    }
}

