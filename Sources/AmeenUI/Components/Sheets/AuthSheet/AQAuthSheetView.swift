//
//  File.swift
//
//
//  Created by Muhammad Ameen Khalil Qadri on 15.10.24.
//

import SwiftUI

extension AQ.Components.Sheets {
    public struct AuthSheetView: View {
        
        public enum AuthenticationScreen: String
        { case logIn = "Enter your login details",
               signUp = "Enter your details to signup",
               resetPassword = "No worries, enter your email."
        }
        @State var screenSelection: AuthenticationScreen = .logIn
        @State var presentationDent: CGFloat = 0
        @State var isTransition = false
        
        var returnAction: (AuthenticationScreen, String, String?, String?) -> ()
        
        
        public init(
            screenSelection: AuthenticationScreen = .logIn,
            returnAction: @escaping (AuthenticationScreen, String, String?, String?) -> ()
        ) {
            self.screenSelection = screenSelection
            self.returnAction = returnAction
        }
        
        public var body: some View {
            ZStack {
                Color.black
                VStack {
                    VStack(alignment: .center, spacing: 10) {
                        Text(screenSelection == .resetPassword ? "Forgot your passoword?" : "Welcome")
                            .font(AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 22))
                            .foregroundColor(AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                            .padding(.top, 40)
                        Text(screenSelection.rawValue)
                            .font(AmeenUIConfig.shared.appFont.regularCustom(fontSize: 18))
                            .foregroundColor(.gray)
                    }
                    
                    
                    switch screenSelection {
                    case .logIn:
                        LoginView(signUpButtonPressed: transitionLogInToSignUp,
                                  goResetPassword: transitionToResetPassword,
                                  userLogin: { email, password in
                            returnAction(.logIn, email, password, nil)
                        })
                        .presentationDetents([.height(450)])
                        .onAppear { presentationDent = 450 }
                        .onDisappear { handleOnDisappear() }
                        .transition(.move(edge: .trailing))
                        
                    case .signUp:
                        SignupView (
                            logInButtonPressed: transitionSignUpToLogIn,
                            userSignUp: { fullName, email, password in
                                returnAction(.signUp, email, password, fullName)
                            }
                        )
                        .presentationDetents([.height(520)])
                        .onAppear { presentationDent = 520 }
                        .onDisappear { handleOnDisappear() }
                        .transition(.move(edge: .leading))
                        
                    case .resetPassword:
                        ResetPasswordView (
                            resetAction: { email in
                                returnAction(.resetPassword, email, nil, nil)
                            },
                            signUpButtonPressed: transitionLogInToSignUp,
                            goToSignIn: transitionSignUpToLogIn
                        )
                        .presentationDetents([.height(360)])
                        .onAppear { presentationDent = 360 }
                        .onDisappear { handleOnDisappear() }
                        .transition(.move(edge: .bottom))
                    }
                }.animation(.easeInOut(duration: 0.4), value: screenSelection)
            }
            .ignoresSafeArea(.keyboard)
            .background(.black)
            .ignoresSafeArea()
        }
        
        func transitionSignUpToLogIn() {
            withAnimation {
                isTransition = true
                screenSelection = .logIn
            }
        }
        
        func transitionToResetPassword() {
            withAnimation {
                isTransition = true
                screenSelection = .resetPassword
            }
        }
        
        func transitionLogInToSignUp() {
            withAnimation {
                isTransition = true
                screenSelection = .signUp
            }
        }
        
        func handleOnDisappear() {
            if isTransition {
                presentationDent = 0
            } else {
                isTransition = false
            }
        }
    }
    
    struct SignupView: View {
        @State var email: String = ""
        @State var password: String = ""
        @State var fullName: String = ""
        @State var lineLength: CGFloat = 0
        @State private var offset: CGFloat = 0
        @State var sheetToggle: Bool = false
        
        let logInButtonPressed : () -> Void
        let userSignUp: (_ fullName: String, _ email: String, _ password: String) -> Void
        
        @Environment(\.colorScheme) var colorScheme
        
        var body: some View {
            NavigationView {
                VStack(spacing: 40) {
                    LazyVStack(spacing: 20) {
                        
                        LazyVStack(alignment: .leading) {
                            
                            Text ("Full Name")
                                .foregroundColor(AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                                .font(AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 18))
                            
                            AQBasicTextField(value: $fullName, placeholderText: "Full name")
                        }
                        LazyVStack(alignment: .leading) {
                            Text ("Email")
                                .foregroundColor(AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                                .font(AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 18))
                            
                            AQBasicTextField(value: $email)
                            
                        }
                        LazyVStack(alignment: .leading) {
                            Text ("Password")
                                .foregroundColor(AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                                .font(AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 18))
                            
                            AQSecureTextField(value: $password, placeholderText: "*****")
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    
                    AQ.Components.AQBasicButton(buttonTitle: "Signup") {
                        HelperFunctions.dismissKeyboard()
                        userSignUp(fullName, email, password)
                    }
                    
                    HStack {
                        Text("Already have an account?")
                            .font(AmeenUIConfig.shared.appFont.boldCustom(fontSize: 15))
                            .foregroundColor(AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                        
                        Button {
                            HelperFunctions.dismissKeyboard()
                            logInButtonPressed()
                        } label: {
                            Text("Login here")
                                .font(AmeenUIConfig.shared.appFont.boldCustom(fontSize: 15))
                                .foregroundColor(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                        }
                    }
                }
                .padding()
                .background(.black)
                
            }
        }
    }
    
    
    struct ResetPasswordView: View {
        @State var email           : String = ""
        @State private var offset  : CGFloat = 0
        @State var isLoading       : Bool = false
        @State var resetAction: (String) -> ()
        
        @State var signUpButtonPressed: () -> Void
        var goToSignIn: () -> ()
        
        
        var body: some View {
            VStack(spacing: 40) {
                
                VStack(alignment: .center, spacing: 10) {
                    
                }
                LazyVStack(spacing: 20) {
                    
                    LazyVStack(alignment: .leading) {
                        Text ("Email")
                            .foregroundColor(AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                            .font(AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 18))
                        
                        AQBasicTextField(value: $email)
                        
                    }.padding(.horizontal, 20)
                }
                
                LazyVStack {
                    
                    AQ.Components.AQBasicButton(buttonTitle: "Reset Password") {
                        HelperFunctions.dismissKeyboard()
                        resetAction(email)
                        isLoading = true
                        goToSignIn()
                    }
                    
                    HStack {
                        Text("Dont have an account?")
                            .font(Fonts.Bold.returnFont(size: 15))
                            .foregroundColor(AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                        
                        Button {
                            signUpButtonPressed()
                        } label: {
                            Text("Sign up here")
                                .font(AmeenUIConfig.shared.appFont.boldCustom(fontSize: 15))
                                .foregroundColor(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                        }
                    }.padding()
                }
                
            }
            .padding()
            .background(.black)
        }
    }
    
    struct LoginView: View {
        @State var email           : String = ""
        @State var password        : String = ""
        @State var lineLength      : CGFloat = 0
        @State private var offset  : CGFloat = 0
        @State var isLoading       : Bool = false
        
        
        @State var signUpButtonPressed: () -> Void
        @State var goResetPassword: () -> Void
        @State var userLogin          : (_ email: String,_ password: String) -> Void
        
        
        var body: some View {
            VStack(spacing: 40) {
                LazyVStack(spacing: 20) {
                    
                    LazyVStack(alignment: .leading) {
                        Text ("Email")
                            .foregroundColor(AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                            .font(AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 18))
                        AQBasicTextField(value: $email)
                        
                    }.padding(.horizontal, 20)
                    
                    LazyVStack(alignment: .leading) {
                        Text ("Password")
                            .foregroundColor(AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                            .font(AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 18))
                        AQSecureTextField(value: $password, placeholderText: "*****")
                        
                        HStack {
                            Spacer()
                            Button {
                                goResetPassword()
                                HelperFunctions.dismissKeyboard()
                            } label: {
                                Text ("Forgot password?")
                                    .foregroundColor(AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                                    .font(Fonts.Medium.returnFont(size: 14))
                            }
                        }
                    } .padding(.horizontal, 20)
                }
                
                LazyVStack {
                    AQ.Components.AQBasicButton(buttonTitle: "Login") {
                        HelperFunctions.dismissKeyboard()
                        userLogin(email, password)
                        isLoading = true
                    }
                    HStack {
                        Text("Dont have an account?")
                            .font(AmeenUIConfig.shared.appFont.boldCustom(fontSize: 15))
                            .foregroundColor(AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                        
                        Button {
                            signUpButtonPressed()
                        } label: {
                            Text("Sign up here")
                                .font(AmeenUIConfig.shared.appFont.boldCustom(fontSize: 15))
                                .foregroundColor(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                        }
                    }.padding()
                }
                
            }
            .padding()
            .background(.black)
        }
    }
    
}
