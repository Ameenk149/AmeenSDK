//
//  AccountView.swift
//  GiveawayInsel
//
//  Created by Muhammad Ameen Qadri on 29.03.24.
//
import SwiftUI

struct AccountView: View {
    @ObservedObject var viewModel: AccountViewModel
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        ZStack {
            Theme.grey
            ScrollView {
                Spacer()
                VStack(spacing: 10) {
                    VStack (spacing: -20) {
                        CreateProfileImageInitials(name: "Ameen")
                            
                    }
                    VStack {
                        TextField("", text: $viewModel.userName)
                            .foregroundStyle(Theme.whiteColor)
                            .font(Fonts.Bold.returnFont(sizeType: .title))
                            .placeholder(when: viewModel.userName.isEmpty) {
                                Text("Username")
                                    .multilineTextAlignment(.trailing)
                                    .foregroundStyle(.gray)
                                    .opacity(0.35)
                                    .font(Fonts.Bold.returnFont(sizeType: .title))
                            }
                            .padding()
                            .background{
                                RoundedRectangle(cornerRadius: Theme.baseRadius)
                                    .foregroundStyle(Theme.textFieldGrey)
                                
                            }
                        
                        Text(viewModel.userEmail)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.gray)
                            .font(Fonts.Bold.returnFont(sizeType: .title))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: Theme.baseRadius)
                                    .foregroundColor(Theme.textFieldGrey)
                            }

                           
                    }
                    if viewModel.userName != "Ameen" {
                        Button(action: {}, label: {
                            Text("Save changes")
                                .font(Fonts.regularButtonFont())
                                .foregroundStyle(Theme.whiteColor)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: Theme.baseRadius)
                                        .foregroundStyle(Theme.mainTheme)
                                }
                        })
                    }
                    HStack {
                        Button(action: {
                            viewModel.showChangePassword()
                        }, label: {
                            Text("Change password")
                                .font(Fonts.regularButtonFont())
                                .foregroundStyle(Theme.whiteColor)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: Theme.baseRadius)
                                        .foregroundStyle(.black)
                                }
                        })
                        
                        Button(action: {
                            viewModel.showDeleteConfirmation.toggle()
                        }, label: {
                            Text("Delete Account")
                                .font(Fonts.regularButtonFont())
                                .foregroundStyle(Theme.whiteColor)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: Theme.baseRadius)
                                        .foregroundStyle(Theme.errorColor)
                                }
                        })
                    }
                  
                }
                .padding()
            }
            .navigationBarTitle("Account")
            .navigationBarTitleDisplayMode(.inline)
           
            .alert(isPresented: $viewModel.showReloginConfirmation) {
                Alert(
                    title: Text("Relogin and try again"),
                    message: Text("This operation is sensitive and requires recent authentication. Log in again before retrying this request"),
                    primaryButton: .default(Text("Logout"), action: { viewModel.logout() }),
                    secondaryButton: .cancel(Text("Cancel"), action: { viewModel.showReloginConfirmation.toggle() })
                )
            }
        }
        .background(Theme.grey)
        .presentationDetents([.fraction(0.42)])
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePickerView(image: $viewModel.profileImage, showImagePicker: $viewModel.showImagePicker, sourceType: $sourceType)
        }
        .sheet(isPresented: $viewModel.showChangePasswordScreen) {
            VStack (spacing: 7) {
                VStack (spacing: 0) {
                    Image(systemName: "person.badge.key.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.white)
                        .padding()
                        .padding(.top, 10)
                    
                    Text("Please enter your old password")
                        .font(Fonts.Bold.returnFont(sizeType: .subtitle))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    SecureField("", text: $viewModel.oldPassword)
                        .placeholder(when: viewModel.oldPassword.isEmpty) {
                            Text("Old password")
                                .foregroundColor(.white)
                                .font(Fonts.Medium.returnFont(sizeType: .title))
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: Theme.baseRadius)
                                .foregroundColor(Theme.textFieldGrey)
                        )
                        .padding()
                        .foregroundStyle(.white)
                        .font(Fonts.Medium.returnFont(sizeType: .title))
                        .tint(.white)
                        .multilineTextAlignment(.leading)
                        .autocapitalization(.none)
                        .keyboardType(.default)
                        .ignoresSafeArea(.keyboard)
                        .animation(.easeIn, value: viewModel.oldPassword)
                    
                    if viewModel.showNewPasswordScreen {
                        SecureField("", text: $viewModel.newPassword)
                            .placeholder(when: viewModel.newPassword.isEmpty) {
                                Text("New password")
                                    .foregroundColor(.white)
                                    .font(Fonts.Medium.returnFont(sizeType: .title))
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: Theme.baseRadius)
                                    .foregroundColor(Theme.textFieldGrey)
                            )
                            .padding(.horizontal)
                            .foregroundStyle(.white)
                            .font(Fonts.Medium.returnFont(sizeType: .title))
                            .tint(.white)
                            .multilineTextAlignment(.leading)
                            .autocapitalization(.none)
                            .keyboardType(.default)
                            .ignoresSafeArea(.keyboard)
                            .animation(.easeIn, value: viewModel.newPassword)
                    }
                }
                Spacer()
                
                if viewModel.showNewPasswordScreen {
                    Button {
                        viewModel.changePassword()
                    } label: {
                        Text("Change password")
                            .font(Fonts.regularButtonFont())
                            .foregroundStyle(.white)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.9)
                            .background {
                                RoundedRectangle(cornerRadius: Theme.baseRadius)
                                    .foregroundStyle(Theme.mainTheme)
                            }
                    }
                }
                else {
                    Button {
                        viewModel.reauthenticateUser()
                    } label: {
                        Text("Next")
                            .font(Fonts.regularButtonFont())
                            .foregroundStyle(.white)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.9)
                            .background {
                                RoundedRectangle(cornerRadius: Theme.baseRadius)
                                    .foregroundStyle(Theme.mainTheme)
                                    
                            }
                    }
                }
            }
            .presentationDetents([.fraction(0.35)])
            .background(Theme.grey)
        }
        .sheet(isPresented: $viewModel.showDeleteConfirmation) {
            VStack (spacing: 7) {
                VStack (spacing: 0) {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(Theme.warningColor)
                        .padding()
                        .padding(.top, 10)
                    
                    Text("Delete account")
                        .font(Fonts.Bold.returnFont(sizeType: .bigTitle))
                        .foregroundStyle(.white)
                        .padding()
                    Text("Would you like to delete your account?")
                        .font(Fonts.Medium.returnFont(sizeType: .subtitle))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                }
                Spacer()
                TwoHorizontalButtons(
                    titleOne: "Cancel",
                    titleTwo: "Delete",
                    actionOne: { viewModel.showDeleteConfirmation.toggle() },
                    actionTwo: {
                        viewModel.deleteUserAccount()
                    })
                
            }
            .presentationDetents([.fraction(0.35)])
            .background(Theme.grey)
        }
        .sheet(isPresented: $viewModel.showError) {
            VStack (spacing: 7) {
                VStack (spacing: 0) {
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(Theme.warningColor)
                        .padding()
                        .padding(.top, 10)
                    
                    Text("Error")
                        .font(Fonts.Bold.returnFont(sizeType: .bigTitle))
                        .foregroundStyle(.white)
                        .padding()
                    Text("You have entered wrong password")
                        .font(Fonts.Medium.returnFont(sizeType: .subtitle))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                }
                Spacer()
                Button {
                    withAnimation {
                        viewModel.showError = false
                        viewModel.showChangePasswordScreen = true
                    }
                } label: {
                    Text("Okay")
                        .font(Fonts.regularButtonFont())
                        .foregroundStyle(.white)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width * 0.9)
                        .background {
                            RoundedRectangle(cornerRadius: Theme.baseRadius)
                                .foregroundStyle(Theme.mainTheme)
                        }
                 }
                
                .background(Theme.grey)
            }
           
            .presentationDetents([.medium])
            .background(Theme.grey)
        }
        
        .preferredColorScheme(.dark)
        .onChange(of: viewModel.profileImage, perform: { newValue in
            if let newImage = newValue {
                viewModel.updateProfileImage(image: newImage)
            }
        })
    }
}

