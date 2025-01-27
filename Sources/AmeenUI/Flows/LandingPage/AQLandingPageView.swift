//
//  File.swift
//  
//
//  Created by Muhammad Ameen Khalil Qadri on 15.10.24.
//

import SwiftUI

extension AQ.Flows {
    public struct LandingPageView: View {
       
        @EnvironmentObject private var toastManager: ToastManager
        @State private var offset: CGFloat = 0
        @State private var isScaled = false
        @State private var opacity: CGFloat = 0
        @State private var loader: Bool = false
        @State private var letsGoButtonText: String
        @State private var presentationDent: CGFloat = 0
        @Binding var showGetInButton: Bool
        private var tagline: String
        private var logoImage: String
        var letsGoButtonPressed: () -> ()
        
       public init(
            tagline: String,
            letsGoButtonText: String,
            logoImage: String,
            showGetInButton: Binding<Bool>,
            buttonAction: @escaping () -> ()
        ) {
            self.tagline = tagline
            self.letsGoButtonText = letsGoButtonText
            self.logoImage = logoImage
            self.letsGoButtonPressed = buttonAction
            self._showGetInButton = showGetInButton
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
                            .font(AmeenUIConfig.shared.appFont.titleMedium())
                            .foregroundColor(AmeenUIConfig.shared.colorPalette.fontSecondaryColor)
                    }
                    .padding(.top, -60)
                    .padding(.bottom, presentationDent - 200)
                    
                    VStack {
                        Spacer()
                        
                        if showGetInButton {
                            AQ.Components.AQBasicButton(
                                buttonTitle: letsGoButtonText,
                                action: letsGoButtonPressed
                            )
                            .padding(.bottom, iPhoneModel.isIPhoneSE() ? 50 : 0)
                            .frame(height: 40.0)
                            .tint(.white)
                        } else {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(width: 20, height: 20)
                        }
                    }
                }
               
            }
           
        }
        
    }
}
