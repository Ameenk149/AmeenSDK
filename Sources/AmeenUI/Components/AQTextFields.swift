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
    let textContentType: UITextContentType?
    @FocusState private var isFocused: Bool
    
    public init(
        value: Binding<String>,
        placeholderText: String = "John@doe.com",
        width: CGFloat = UIScreen.main.bounds.width * 0.8,
        height: CGFloat = UIScreen.main.bounds.width * 0.13,
        hasError: Binding<Bool> = .constant(false),
        keyboardType: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil
    ) {
        self._value = value
        self.placeholderText = placeholderText
        self.width = width
        self.height = height
        self._hasError = hasError
        self.keyboardType = keyboardType
        self.textContentType = textContentType
   }
    public init(
        value: Binding<Int>,
        placeholderText: String = "john@doe.com",
        width: CGFloat = UIScreen.main.bounds.width * 0.8,
        height: CGFloat = UIScreen.main.bounds.width * 0.13 ,
        hasError: Binding<Bool> = .constant(false),
        keyboardType: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil
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
          self.textContentType = textContentType
      }
    
    public var body: some View {
        // The TextField fills the whole box (padding inside, background behind), so every
        // tap lands on it directly instead of a separate tap gesture racing the sheet's drag.
        TextField("", text: $value)
            .focused($isFocused)
            .font(AmeenUIConfig.shared.appFont.titleMedium())
            .foregroundColor(Theme.whiteColor)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(keyboardType == .emailAddress)
            .keyboardType(keyboardType)
            .textContentType(textContentType)
            .multilineTextAlignment(.leading)
            .tint(.gray)
            .padding(.horizontal)
            .frame(width: width, height: height)
            .placeholder(when: value.isEmpty) {
                Text(placeholderText)
                    .font(AmeenUIConfig.shared.appFont.titleMedium())
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
                    .allowsHitTesting(false)
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(AmeenUIConfig.shared.colorPalette.textFieldBackgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(hasError ? Color.red : (isFocused ? AmeenUIConfig.shared.colorPalette.buttonPrimaryColor : Color.clear), lineWidth: 1)
                    .allowsHitTesting(false)
            )
            .contentShape(RoundedRectangle(cornerRadius: 10))
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
    @FocusState private var isFocused: Bool
    let placeholderText: String
    let textContentType: UITextContentType
    
    public init(
        value: Binding<String>,
        placeholderText: String = "john@doe.com",
        textContentType: UITextContentType = .password
    ) {
        self._value = value
        self.placeholderText = placeholderText
        self.textContentType = textContentType
    }
    
    public var body: some View {
        HStack {
            // Both variants share one focus binding, so toggling visibility keeps the keyboard up.
            Group {
                if isPasswordVisible {
                    TextField("", text: $value)
                } else {
                    SecureField("", text: $value)
                }
            }
            .focused($isFocused)
            .font(AmeenUIConfig.shared.appFont.titleMedium())
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .keyboardType(.default)
            .textContentType(textContentType)
            .multilineTextAlignment(.leading)
            .tint(.gray)
            .frame(maxHeight: .infinity)
            
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.gray)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
        }
        .padding(.leading)
        .padding(.trailing, 4)
        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.13)
        .placeholder(when: value.isEmpty) {
            Text(placeholderText)
                .font(AmeenUIConfig.shared.appFont.titleMedium())
                .foregroundColor(.gray)
                .padding(.leading, 16)
                .allowsHitTesting(false)
        }
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(AmeenUIConfig.shared.colorPalette.textFieldBackgroundColor)
        )
        .contentShape(RoundedRectangle(cornerRadius: 10))
        // Taps on the padding around the field (not the eye button) still focus it.
        .onTapGesture { isFocused = true }
        .foregroundColor(Theme.whiteColor)
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
