//
//  File.swift
//  
//
//  Created by Muhammad Ameen Khalil Qadri on 15.10.24.
//

import SwiftUI

public struct AQBasicTextField: View {
    @Binding var value: String
    let placeholderText: String
    
    public init(value: Binding<String>, placeholderText: String = "john@doe.com") {
        self._value = value
        self.placeholderText = placeholderText
    }
    
    public var body: some View {
        TextField(placeholderText, text: $value)
            .padding()
            .placeholder(when: $value.wrappedValue.isEmpty) {
                Text(placeholderText)
                    .font(AmeenUIConfig.shared.appFont.titleMedium())
                    .foregroundColor(AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                    .padding(.leading, 20)
            }
            .background(
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundColor(AmeenUIConfig.shared.colorPalette.textFieldBackgroundColor)
            )
            .font(Fonts.Medium.returnFont(size: 18))
            .frame(width: UIScreen.main.bounds.width * 0.8)
            .foregroundColor(Theme.whiteColor)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .multilineTextAlignment(.leading)
            .ignoresSafeArea(.keyboard)
            .tint(.gray)
    }
}

public struct AQSecureTextField: View {
    @Binding var value: String
    let placeholderText: String
    
    public init(value: Binding<String>, placeholderText: String = "john@doe.com") {
        self._value = value
        self.placeholderText = placeholderText
    }
    
    public var body: some View {
        SecureField(placeholderText, text: $value)
            .padding()
            .placeholder(when: $value.wrappedValue.isEmpty) {
                Text(placeholderText)
                    .font(Fonts.Medium.returnFont(size: 18))
                    .foregroundColor(AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                    .padding(.leading, 20)
                    .padding(.top, 15)
            }
            .background(
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundColor(AmeenUIConfig.shared.colorPalette.textFieldBackgroundColor)
            )
            .font(Fonts.Medium.returnFont(size: 18))
            .frame(width: UIScreen.main.bounds.width * 0.8)
            .foregroundColor(Theme.whiteColor)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .multilineTextAlignment(.leading)
            .ignoresSafeArea(.keyboard)
            .tint(.gray)
    }
}
