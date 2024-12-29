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
    
    public init(value: Binding<String>, placeholderText: String = "john@doe.com", width: CGFloat = UIScreen.main.bounds.width * 0.8, height: CGFloat = UIScreen.main.bounds.width * 0.1) {
        self._value = value
        self.placeholderText = placeholderText
        self.width = width
        self.height = height
   
    }
    public init(value: Binding<Int>, placeholderText: String = "john@doe.com", width: CGFloat = UIScreen.main.bounds.width * 0.8, height: CGFloat = UIScreen.main.bounds.width * 0.1) {
          self._value = Binding(
              get: { String(value.wrappedValue) },
              set: { value.wrappedValue = Int($0) ?? 0 } // Set to 0 if conversion fails
          )
          self.placeholderText = placeholderText
          self.width = width
          self.height = height
      }
    
    public var body: some View {
        TextField("", text: $value)
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

public struct AQTwoHorizontalTextField: View {
    @Binding private var firstValue: String
    @Binding private var secondValue: String
   
    let firstPlaceholderText: String
    let secondPlaceholderText: String
    
    public init(firstValue: Binding<String>, secondValue: Binding<String>, firstPlaceholderText: String = "Placeholder 1", secondPlaceholderText: String = "Placeholder 2") {
        self._firstValue = firstValue
        self._secondValue = secondValue
        self.firstPlaceholderText = firstPlaceholderText
        self.secondPlaceholderText = secondPlaceholderText
       
    }
    
    public var body: some View {
        HStack(spacing: 16) { // Horizontal stack for equal-width text fields
            AQBasicTextField(value: $firstValue, placeholderText: firstPlaceholderText, width: UIScreen.main.bounds.width / 2.6)
            AQBasicTextField(value: $secondValue, placeholderText: secondPlaceholderText, width: UIScreen.main.bounds.width / 2.6)
        }
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
        SecureField("", text: $value)
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
            .font(AmeenUIConfig.shared.appFont.titleMedium())
            .frame(width: UIScreen.main.bounds.width * 0.8)
            .foregroundColor(Theme.whiteColor)
            .autocapitalization(.none)
            .keyboardType(.emailAddress)
            .multilineTextAlignment(.leading)
            .ignoresSafeArea(.keyboard)
            .tint(.gray)
    }
}

public struct AQTextEditor: View {
    @Binding private var value: String
    private var width: CGFloat = UIScreen.main.bounds.width * 0.8
    private var height: CGFloat = UIScreen.main.bounds.width * 0.1
    let placeholderText: String
    
    public init(value: Binding<String>, placeholderText: String = "john@doe.com", width: CGFloat = UIScreen.main.bounds.width * 0.8, height: CGFloat = UIScreen.main.bounds.width * 0.1) {
        self._value = value
        self.placeholderText = placeholderText
        self.width = width
        self.height = height
   
    }
    public init(value: Binding<Int>, placeholderText: String = "john@doe.com", width: CGFloat = UIScreen.main.bounds.width * 0.8, height: CGFloat = UIScreen.main.bounds.width * 0.1) {
          self._value = Binding(
              get: { String(value.wrappedValue) },
              set: { value.wrappedValue = Int($0) ?? 0 } // Set to 0 if conversion fails
          )
          self.placeholderText = placeholderText
          self.width = width
          self.height = height
      }
    
    public var body: some View {
        TextEditor(text: $value)
            .scrollContentBackground(.hidden)
            .placeholder(when: $value.wrappedValue.isEmpty) {
                Text(placeholderText)
                    .font(AmeenUIConfig.shared.appFont.titleMedium())
                    .foregroundColor(Color.gray)
                    .padding(.leading, 10)
                    .padding(.top, -12)
                    
            }
            .padding()
            .font(AmeenUIConfig.shared.appFont.titleMedium())
            .foregroundStyle(Theme.whiteColor)
            .frame(width: width, height: height)
            .cornerRadius(10)
            .background(
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundColor(AmeenUIConfig.shared.colorPalette.textFieldBackgroundColor)
            )
            
    }
}
