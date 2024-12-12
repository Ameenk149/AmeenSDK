//
//  BottomAlertSheet.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 27.11.24.
//

import SwiftUI


public struct BottomAlertSheet: View {
   
    let message: String
    let buttonTitle: String
    let buttonAction: () -> ()
    let title: String
    let errorSystemImage: String
    
    public init(title: String = "Whoops!", message: String, buttonTitle: String, buttonAction: @escaping () -> Void, errorSystemImage: String) {
        self.message = message
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
        self.errorSystemImage = errorSystemImage
        self.title = title
    }
    
    public var body: some View {
        VStack(spacing: 10) {
            
            
            AQ.Components.AQSystemImage(systemImage: errorSystemImage, width: 100, height: 100)
                .padding()
            Text(title)
                .font(AmeenUIConfig.shared.appFont.boldCustom(fontSize: 16))
                .foregroundColor(.white)
                .shadow(radius: 10)
                .multilineTextAlignment(.center)
            Text(message)
                .font(AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 14))
                .foregroundColor(.white)
                .shadow(radius: 10)
                .multilineTextAlignment(.center)
                .padding()
                .lineLimit(3)
                .frame(maxWidth: .infinity)
            
            Spacer()
            AQ.Components.AQBasicButton(buttonTitle: buttonTitle, action: buttonAction)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .presentationDetents([.fraction(0.43)])
        
    }
}
