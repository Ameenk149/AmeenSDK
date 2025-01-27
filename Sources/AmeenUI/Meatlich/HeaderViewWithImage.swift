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
        var address: String = "Am Wasserwork 201, 15843\nBerlin"
        var detailPageHeaderImage: String = "sakhiHeader"
        var logoImage: String = "logoImage"
        var origin: String = "Poland"
        var additionalTag: String = "Shockfree"
        @State private var originTip = false
        
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
                        .frame(height: 250)
                        .clipped()
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
                    
                    AQ.Components.AQText(text: vendorName)
                        .padding(.bottom)
                    
                    AQ.Components.AQText(text: address,
                                        font: AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 15),
                                        textColor: AmeenUIConfig.shared.colorPalette.secondaryColor)
                    AQ.Components.AQText(text: "Berlin",
                                        font: AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 15),
                                        textColor: AmeenUIConfig.shared.colorPalette.secondaryColor)
                    HStack{
                        Group {
                            HStack{
                                AQ.Components.AQImageButton(systemImage: "location.fill",
                                                            width: 15,
                                                            height: 15,
                                                            backgroundColor: .white,
                                                            action: {
                                    originTip.toggle()
                                })
                               
                                    AQ.Components.AQText(text: "Origin: \(origin)",
                                                         font: AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 15),
                                                         textColor: .white)
                                    
                                
                            }
                            .aqSheet(title: "Info", isPresented: $originTip, content: {
                                Text("The meat is slaughtered in Poland where it is made sure that the meat remains 100% halal, and hut cut.")
                                    .font(AmeenUIConfig.shared.appFont.regularCustom(fontSize: 14))
                                    .foregroundColor(.white)
                                    .shadow(radius: 10)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .presentationDetents([.fraction(0.20)])
                                    .preferredColorScheme(.dark)
                            })
                            HStack{
                                AQ.Components.AQImageButton(systemImage: "info.circle.fill",
                                                            width: 15,
                                                            height: 15,
                                                            backgroundColor: .white,
                                                            action: {  originTip.toggle() })
                                AQ.Components.AQText(text: "\(additionalTag)",
                                                     font: AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 15),
                                                     textColor: .white)
                            }
                        }
                    }
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

