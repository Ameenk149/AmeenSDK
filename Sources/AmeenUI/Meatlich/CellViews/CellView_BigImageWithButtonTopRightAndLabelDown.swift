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
        var title: String
        
        public init(imageName: String, buttonImage: String, title: String, action:@escaping ()->()) {
            self.imageName = imageName
            self.buttonImage = buttonImage
            self.action = action
            self.title = title
        }
        
        public var body: some View {
            ZStack {
                AQ.Components.AQRemoteImage(imageName: imageName)
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
                        AQ.Components.AQText(text: title, fontSize: 18)
                            .padding()
                        Spacer()
                    }
                    .AQGradientBackground()
                }
            }
            .onTapGesture {
                action()
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
            let trailingText: String
            let action: () -> ()
            
            public init(
                imageName: String,
                buttonImage: String,
                title: String,
                description: String,
                width: CGFloat = 100,
                height: CGFloat = 100,
                trailingText: String = "$100",
                action: @escaping () -> ()
            ) {
                self.imageName = imageName
                self.buttonImage = buttonImage
                self.title = title
                self.description = description
                self.height = height
                self.width = width
                self.action = action
                self.trailingText = trailingText
            }
            
            public var body: some View {
                ZStack {
                    AmeenUIConfig.shared.colorPalette.secondaryColor
                    HStack {
                        AQ.Components.AQRemoteImage(imageName: imageName, width: width, height: height)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            AQ.Components.AQText(
                                text: title,
                                font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 16))
                            
                            AQ.Components.AQText(
                                text: description,
                                fontSize: 10
                            )
                        }
                        Spacer()
                        AQ.Components.AQText(
                            text: trailingText,
                            font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 16))
//                        AQ.Components.AQImageButtonCustomImage(image: buttonImage) {
//                            action()
//                        }
                        .padding(.horizontal)
                    }
                }
                .cornerRadius(10)
                .onTapGesture {
                    action()
                }
            }
        }
        
        public struct CellView_Inventory: View {
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
                            HStack {
                                
                                AQ.Components.AQText(
                                    text: title,
                                    font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 16))
                                
                                AQ.Components.AQText(
                                    text: "In stock",
                                    font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 12))
                                .padding(4)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(.green)
                                }
                                
                                AQ.Components.AQText(
                                    text: "Active",
                                    font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 12))
                                .padding(4)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                                }
                                
                            }
                            AQ.Components.AQText(
                                text: description,
                                fontSize: 12,
                                textColor: AmeenUIConfig.shared.colorPalette.fontPrimaryColor.opacity(0.4)
                            )
                            AQ.Components.AQText(
                                text: "Current stock: 25kgs",
                                font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 12))
                            
                            
                            
                        }
                        Spacer()
                        AQ.Components.AQText(
                            text: "$20",
                            fontSize: 16
                        )
                        
                        Spacer()
                    }
                }
                .cornerRadius(10)
                .onTapGesture {
                    action()
                }
            }
        }
        
    }
