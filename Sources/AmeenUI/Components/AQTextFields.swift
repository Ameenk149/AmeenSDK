//
//  File.swift
//  
//
//  Created by Muhammad Ameen Khalil Qadri on 15.10.24.
//

import SwiftUI

public struct AQBasicTextField: View {
    @Binding private var value: String
    private var width: CGFloat = UIScreen.main.bounds.width * 0.8
    private var height: CGFloat = UIScreen.main.bounds.width * 0.1
    let placeholderText: String
    
    public init(value: Binding<String>, placeholderText: String = "john@doe.com") {
        self._value = value
        self.placeholderText = placeholderText
    }
    public init(value: Binding<Int>, placeholderText: String = "john@doe.com", width: CGFloat = UIScreen.main.bounds.width * 0.8, height: CGFloat = UIScreen.main.bounds.width * 0.1) {
          self._value = Binding(
              get: { String(value.wrappedValue) },
              set: { value.wrappedValue = Int($0) ?? 0 } // Set to 0 if conversion fails
          )
          self.width = width
          self.placeholderText = placeholderText
          self.height = height
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
            .frame(width: width, height: height)
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
