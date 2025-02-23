//
//  SignInView.swift
//  AmeenSDK
//
//  Created by Muhammad Qadri on 23.02.25.
//


import SwiftUI
import AuthenticationServices

struct ExtraSignInView: View {
    var body: some View {
        
        let buttonWidth = UIScreen.main.bounds.width * 0.39
            let buttonHeight: CGFloat = 50

            HStack(spacing: 10) {
                // Apple Sign-In Button
                SignInWithAppleButton(
                    onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                    },
                    onCompletion: { result in
                        switch result {
                        case .success(let authResults):
                            print("Apple Sign-In Successful: \(authResults)")
                        case .failure(let error):
                            print("Apple Sign-In Failed: \(error.localizedDescription)")
                        }
                    }
                )
                .frame(width: buttonWidth, height: buttonHeight)
                .signInWithAppleButtonStyle(.black) // Use white for light mode

                // Google Sign-In Button (Using Custom Look)
                Button(action: {
                    print("Google Sign-In Tapped")
                    // Implement Google Sign-In Logic
                }) {
                    HStack {
                        Image(systemName: "globe") // Replace with Google logo
                            .resizable()
                            .frame(width: 14, height: 14)
                        Text("Sign in with Google")
                            .font(.system(size: 13, weight: .medium))
                    }
                    .foregroundColor(.black)
                    .frame(width: buttonWidth, height: buttonHeight)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                }
            }
            .padding()
        
    }
}
