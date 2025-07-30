//
//  HeaderViewWithImage.swift
//
//
//  Created by Muhammad Ameen Khalil Qadri on 17.10.24.
//

import SwiftUI
import Kingfisher

extension AQ.Meatlich {
    public struct HeaderViewWithImage: View {
        
        var vendorName: String = "Sakhi Halal Meat"
        var address: String = "Am Wasserwork 201, 15843"
        var city: String = "Berlin"
        var detailPageHeaderImage: String = "sakhiHeader"
        var logoImage: String = "logoImage"
        var origin: String = "Poland"
        var additionalTag: String = "Shockfree"
        var description: String = ""
        var email: String = ""
        var phone: String = ""
        @State private var originTip = false
        
        public init(
          vendorName: String,
          address: String,
          logoImage: String,
          detailPageHeaderImage: String,
          city: String = "Berlin",
          description: String,
          email: String,
          phone: String
        ) {
            self.vendorName = vendorName
            self.address = address
            self.logoImage = logoImage
            self.detailPageHeaderImage = detailPageHeaderImage
            self.city = city
            self.description = description
            self.email = email
            self.phone = phone
        }
        public init() {}
        
        public var body: some View {
            ZStack {
                // Image at the top (meat image)
                VStack(spacing: 0) {
                    let imageUrl = URL(string: detailPageHeaderImage)
                    KFImage(imageUrl)
                        .placeholder {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle())
                                            .frame(width: 50, height: 50)
                                    }
                        .onFailureImage(KFCrossPlatformImage(systemName: "photo.badge.exclamationmark"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: 250)
                        .clipped()
                    Rectangle()
                        .foregroundStyle(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                        .frame(maxWidth: .infinity, maxHeight: 10)
                        
                    Spacer()
                }
                .frame(height: 437)
               
                VStack(spacing: 0) {
                   let imageUrl = URL(string: logoImage)
                    KFImage(imageUrl)
                        .placeholder {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle())
                                            .frame(width: 50, height: 50)
                                    }
                        .onFailureImage(KFCrossPlatformImage(systemName: "photo.badge.exclamationmark"))
                        .resizable()
                        .frame(width: 100, height: 100)
                        .shadow(radius: 4)
                        .padding()
                    
                    AQ.Components.AQText(text: vendorName, fontSize: 25)
                    
                    AQ.Components.AQText(
                      text: address + " " + city,
                      font: AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 14),
                      textColor: AmeenUIConfig.shared.colorPalette.secondaryColor
                    )
                  AQ.Components.AQLink(
                    text: phone,
                    url: URL(string: "tel:\(phone)")!,
                    font: AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 14),
                    textColor: AmeenUIConfig.shared.colorPalette.primaryColor
                  )
                   AQ.Components.AQLink(
                     text: email,
                     url: URL(string: "mailto:\(email)")!,
                     font: AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 14),
                     textColor: AmeenUIConfig.shared.colorPalette.primaryColor
                   )
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

