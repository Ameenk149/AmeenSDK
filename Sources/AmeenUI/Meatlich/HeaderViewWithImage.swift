//
//  HeaderViewWithImage.swift
//
//
//  Created by Muhammad Ameen Khalil Qadri on 17.10.24.
//

import SwiftUI

extension AQ.Meatlich {
    public struct HeaderViewWithImage: View {
        
        var vendorName: String = "Sakhi Halal Meat"
        var address: String = "Am Wasserwork 201, 15843\nBerlin"
        var detailPageHeaderImage: String = "sakhiHeader"
        var logoImage: String = "logoImage"
        
        
        public init(vendorName: String, address: String, logoImage: String, detailPageHeaderImage: String) {
            self.vendorName = vendorName
            self.address = address
            self.logoImage = logoImage
            self.detailPageHeaderImage = detailPageHeaderImage
        }
        public init() {}
        
        public var body: some View {
            ZStack {
                // Image at the top (meat image)
                VStack {
                    Image(detailPageHeaderImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()
                    Spacer()
                }
                .frame(height: 437)
                // Vendor logo with details
                VStack(spacing: 0) {
                    // Vendor logo
                    
                    Image(logoImage)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .shadow(radius: 4)
                        .padding()
                    
                    AQ.Components.AQText(text: vendorName)
                        .padding(.bottom)
                    
                    AQ.Components.AQText(text: address,
                                        font: AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 15),
                                        textColor: AmeenUIConfig.shared.colorPalette.secondaryColor)
                    AQ.Components.AQText(text: "Berlin",
                                        font: AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 15),
                                        textColor: AmeenUIConfig.shared.colorPalette.secondaryColor)
                    
                }
                .padding(.top, 150)
                .frame(maxWidth: .infinity)
                .background(Color.clear)
                .shadow(radius: 10)
            }
            .frame(maxHeight: .infinity)
        
        }
    }
    
    public struct HeaderViewWithoutImage: View {
        
        var title: String = "Sakhi Halal Meat"
        var subtitle: String = "Am Wasserwork 201, 15843\nBerlin"
        
        public init(title: String, subtitle: String) {
            self.title = title
            self.subtitle = subtitle
        }
        
        public var body: some View {
            ZStack {
                VStack(spacing: 0) {
                    AQ.Components.AQText(text: title)
                        .padding(.bottom)
                    
                    AQ.Components.AQText(text: subtitle,
                                        font: AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 15),
                                        textColor: AmeenUIConfig.shared.colorPalette.secondaryColor)
                    
                }
                .background(Color.clear)
                .shadow(radius: 10)
            }
            
        
        }
    }
}

