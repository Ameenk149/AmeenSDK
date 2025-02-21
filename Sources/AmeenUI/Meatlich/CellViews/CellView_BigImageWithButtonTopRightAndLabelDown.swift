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
        var index: Int
        var action: (Int) -> ()
        var title: String
        
        public init(imageName: String, buttonImage: String, title: String, index: Int, action:@escaping (Int)->()) {
            self.imageName = imageName
            self.buttonImage = buttonImage
            self.action = action
            self.title = title
            self.index = index
        }
        
        public var body: some View {
            ZStack {
                AQ.Components.AQRemoteImage(imageName: imageName)
                    .cornerRadius(10)
                VStack {
                    HStack {
                        Spacer()
                        AQ.Components.AQImageButtonCustomImage(image: buttonImage, action: {
                            action(index)
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
            .frame(width: 202, height: 260)
            .onTapGesture {
                action(index)
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
            let promoText: String
            let trailingText: String
            let outOfStock: Bool
            let action: () -> ()
            
            public init(
                imageName: String,
                buttonImage: String,
                title: String,
                description: String,
                width: CGFloat = 100,
                height: CGFloat = 100,
                trailingText: String = "$100",
                promoText: String = "$90",
                outOfStock: Bool = false,
                action: @escaping () -> ()
            ) {
                self.imageName = imageName
                self.buttonImage = buttonImage
                self.title = title
                self.description = description
                self.height = height
                self.width = width
                self.action = action
                self.promoText = promoText
                self.trailingText = trailingText
                self.outOfStock = outOfStock
            }
            
            public var body: some View {
                ZStack {
                    AmeenUIConfig.shared.colorPalette.secondaryColor
                    
                    HStack {
                        AQ.Components.AQRemoteImage(
                            imageName: imageName,
                            width: width,
                            height: height,
                            isNotForRedaction: true
                        )
                        
                        VStack(alignment: .leading, spacing: 5) {
                           AQ.Components.AQText(
                                    text: title,
                                    font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 16))
                                
                            
                            AQ.Components.AQText(
                                text: description,
                                fontSize: 10,
                                lineLimit: 2
                            )

                                if outOfStock {
                                    AQ.Components.AQText(
                                        text: "Out of stock",
                                        font: AmeenUIConfig.shared.appFont.subtitleBold(),
                                        textColor: .red
                                    )
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .padding()
                                    }
                                }
                                else if promoText != trailingText {
                                    AQ.Components.AQText(
                                        text: "Promo",
                                        font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 10)
                                    )
                                    .padding(.horizontal)
                                    .padding(.vertical, 2)
                                    .background {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundStyle(.red)
                                    }
                                    .shadow(radius: 10)
                                }

                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            AQ.Components.AQText(
                                text: "\(trailingText)",
                                font: AmeenUIConfig.shared.appFont.boldCustom(
                                    fontSize: 12),
                                textColor: promoText != trailingText ?  .white.opacity(0.7) : .white,
                                isStrikeThrough: promoText != trailingText
                            )
                            .padding(.trailing)
                            
                            if promoText != trailingText {
                                AQ.Components.AQText(
                                    text: "\(promoText)",
                                    font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 14)
                                )
                                .padding(.trailing)
                            }
                        }
                        
//                        AQ.Components.AQImageButtonCustomImage(image: buttonImage) {
//                            action()
//                        }
                        
                    }
                }
                
                .cornerRadius(10)
                .onTapGesture {
                    if !outOfStock {
                        action()
                    }
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
