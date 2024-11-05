//
//  File.swift
//  
//
//  Created by Muhammad Ameen Khalil Qadri on 15.10.24.
//

import SwiftUI

extension AQ.Flows {
    public struct LandingPageView: View {
        
        @State private var offset: CGFloat = 0
        @State private var isScaled = false
        @State private var opacity: CGFloat = 0
        @State private var presentationDent: CGFloat = 0
        @EnvironmentObject private var toastManager: ToastManager
        
        private var tagline: String
        private var letsGoButtonText: String
        private var logoImage: String
        
        var letsGoButtonPressed: () -> ()
        
       public init(
            tagline: String,
            letsGoButtonText: String,
            logoImage: String,
            buttonAction: @escaping () -> ()
        ) {
            self.tagline = tagline
            self.letsGoButtonText = letsGoButtonText
            self.logoImage = logoImage
            self.letsGoButtonPressed = buttonAction
        }
        
        public var body: some View {
            
            NavigationStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(AmeenUIConfig.shared.colorPalette.backgroundColor)
                    VStack {
                        Image(logoImage, bundle: .main)
                            .resizable()
                            .frame(width: 70, height: 70)
                        Text(AmeenUIConfig.shared.projectData.appName)
                            .font(AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 40))
                            .opacity(opacity)
                            .foregroundColor(AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                            .onAppear() {
                                withAnimation(Animation.easeInOut(duration: 1.0)) {
                                    self.opacity = 1.0
                                }
                            }
                        Text(tagline)
                            .font(AmeenUIConfig.shared.appFont.titleBold())
                            .foregroundColor(AmeenUIConfig.shared.colorPalette.fontSecondaryColor)
                    }
                    .padding(.top, -60)
                    .padding(.bottom, presentationDent - 200)
                    
                    VStack {
                        Spacer()
                        
                        AQ.Components.AQBasicButton(
                            buttonTitle: "Lets get in",
                            action: letsGoButtonPressed
                        )
                        .padding(.bottom, iPhoneModel.isIPhoneSE() ? 50 : 0)
                        .frame(height: 40.0)
                        .tint(.white)
                    }
                }
               
            }
           
        }
        
    }
}
