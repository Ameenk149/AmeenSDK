//
//  File.swift
//  
//
//  Created by Muhammad Ameen Khalil Qadri on 15.10.24.
//

import SwiftUI

public struct AQBasicTextField: View {
    @Binding private var value: String
    @Binding private var hasError: Bool
    private var width: CGFloat = UIScreen.main.bounds.width * 0.8
    private var height: CGFloat = UIScreen.main.bounds.width * 0.13
    let placeholderText: String
    let keyboardType: UIKeyboardType
    @FocusState private var isFocused: Bool
    
    public init(
        value: Binding<String>,
        placeholderText: String = "John@doe.com",
        width: CGFloat = UIScreen.main.bounds.width * 0.8,
        height: CGFloat = UIScreen.main.bounds.width * 0.13,
        hasError: Binding<Bool> = .constant(false),
        keyboardType: UIKeyboardType = .default
    ) {
        self._value = value
        self.placeholderText = placeholderText
        self.width = width
        self.height = height
        self._hasError = hasError
        self.keyboardType = keyboardType
   }
    public init(
        value: Binding<Int>,
        placeholderText: String = "john@doe.com",
        width: CGFloat = UIScreen.main.bounds.width * 0.8,
        height: CGFloat = UIScreen.main.bounds.width * 0.13 ,
        hasError: Binding<Bool> = .constant(false),
        keyboardType: UIKeyboardType = .default
    ) {
          self._value = Binding(
              get: { String(value.wrappedValue) },
              set: { value.wrappedValue = Int($0) ?? 0 } // Set to 0 if conversion fails
          )
          self.placeholderText = placeholderText
          self.width = width
          self.height = height
          self._hasError = hasError
         self.keyboardType = keyboardType
      }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(AmeenUIConfig.shared.colorPalette.textFieldBackgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(hasError ? Color.red : (isFocused ? AmeenUIConfig.shared.colorPalette.buttonPrimaryColor : Color.clear), lineWidth: 1)
                )
                .frame(width: width, height: height)
                .contentShape(Rectangle()) // Ensures tap detection over the entire shape
                .onTapGesture {
                    isFocused = true // Focus the TextField when the background is tapped
                }
                
            
            TextField("", text: $value)
                .focused($isFocused)
                .padding()
                .placeholder(when: $value.wrappedValue.isEmpty) {
                    Text(placeholderText)
                        .font(AmeenUIConfig.shared.appFont.titleMedium())
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
                }
                .font(AmeenUIConfig.shared.appFont.titleMedium())
                .frame(width: width, height: height)
                .foregroundColor(Theme.whiteColor)
                .autocapitalization(.none)
                .keyboardType(keyboardType)
                .multilineTextAlignment(.leading)
                .ignoresSafeArea(.keyboard)
                .tint(.gray)
        }
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
    @State private var isPasswordVisible: Bool = false
    let placeholderText: String
    
    public init(value: Binding<String>, placeholderText: String = "john@doe.com") {
        self._value = value
        self.placeholderText = placeholderText
    }
    
    public var body: some View {
        HStack {
            if isPasswordVisible {
                TextField("", text: $value)
                    .font(AmeenUIConfig.shared.appFont.titleMedium())
                    .autocapitalization(.none)
                    .keyboardType(.default)
                    .multilineTextAlignment(.leading)
                    .tint(.gray)
            } else {
                SecureField("", text: $value)
                    .font(AmeenUIConfig.shared.appFont.titleMedium())
                    .autocapitalization(.none)
                    .keyboardType(.default)
                    .multilineTextAlignment(.leading)
                    .tint(.gray)
            }
            
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .placeholder(when: $value.wrappedValue.isEmpty) {
            Text(placeholderText)
                .font(AmeenUIConfig.shared.appFont.titleMedium())
                .foregroundColor(.gray)
                .padding(.leading, 20)
        }
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(AmeenUIConfig.shared.colorPalette.textFieldBackgroundColor)
        )
        .frame(width: UIScreen.main.bounds.width * 0.8)
        .foregroundColor(Theme.whiteColor)
        .ignoresSafeArea(.keyboard)
    }
}

public struct AQTextEditor: View {
    @Binding private var value: String
    private var width: CGFloat = UIScreen.main.bounds.width * 0.8
    private var height: CGFloat = UIScreen.main.bounds.width * 0.1
    let placeholderText: String
    private let characterLimit = 100 // Maximum character limit
    @FocusState private var responseIsFocussed: Bool // dismiss response editor keyboard when hit Return

    public init(value: Binding<String>, placeholderText: String = "john@doe.com", width: CGFloat = UIScreen.main.bounds.width * 0.8, height: CGFloat = UIScreen.main.bounds.width * 0.1) {
        self._value = value
        self.placeholderText = placeholderText
        self.width = width
        self.height = height
    }
    
    public init(value: Binding<Int>, placeholderText: String = "john@doe.com", width: CGFloat = UIScreen.main.bounds.width * 0.8, height: CGFloat = UIScreen.main.bounds.width * 0.1) {
        self._value = Binding(
            get: { String(value.wrappedValue) },
            set: { value.wrappedValue = Int($0) ?? 0 }
        )
        self.placeholderText = placeholderText
        self.width = width
        self.height = height
    }
    
    public var body: some View {
        TextEditor(text: $value)
            .focused($responseIsFocussed)
                       .onReceive(value.publisher.last()) {
                           if ($0 as Character).asciiValue == 10 {
                               responseIsFocussed = false
                               value.removeLast()
                           }
                       }
            .scrollContentBackground(.hidden)
            .onChange(of: value) { newValue in
                if newValue.count > characterLimit {
                    value = String(newValue.prefix(characterLimit))
                }
            }
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

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
