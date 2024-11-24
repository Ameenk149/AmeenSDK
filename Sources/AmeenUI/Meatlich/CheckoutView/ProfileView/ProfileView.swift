//
//  ProfileView.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 01.11.24.
//

import Foundation
import SwiftUI

extension AQ.Meatlich {
    public struct ProfileView: View {
         @StateObject var viewModel = ProfileViewModel()
        
        public init() {
          
        }
        
        public var body: some View {
            NavigationStack{
                ZStack{
                    AmeenUIConfig.shared.colorPalette.backgroundColor
                    ScrollView {
                        VStack() {
                            Spacer()
                                .frame(height: UIScreen.main.bounds.height / 20)
                            HeaderView(viewModel: viewModel)
                            Spacer()
                            ButtonsView(viewModel: viewModel)
                            
                        }
                    }
                    .frame(maxHeight: .infinity)
                   
                }
                .sheet(isPresented: $viewModel.confirmLogoutAlert) {
                    Logout(viewModel: viewModel)
                }
                .sheet(isPresented: $viewModel.accountSheet) {
                    AccountView(viewModel: AccountViewModel())
                        .presentationDetents([.fraction(iPhoneModel.isIPhoneSE() ? 0.5 : 0.4)])
                }
                .sheet(isPresented: $viewModel.provideFeedback) {
                    FeedbackView()
                        .presentationDetents([.fraction(0.4)])
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .foregroundColor(.white)
                        .font(Fonts.Bold.returnFont(sizeType: .title))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.confirmLogout()
                    } label: {
                        
                        Text("Logout")
                            .font(Fonts.regularButtonFont())
                            .foregroundStyle(.white)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width / 4, height: 30)
                            .background {
                                RoundedRectangle(cornerRadius: Theme.baseRadius)
                                    .foregroundStyle(Theme.errorColor)
                            }
                    }
                }
            }
            .background(AmeenUIConfig.shared.colorPalette.backgroundColor)
        }
    }
    
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
    
    struct HeaderView: View {
        @StateObject var viewModel: ProfileViewModel
        var body: some View {
            VStack (alignment: .center){
                
                CreateProfileImageInitials(name: "Ameen")
                
                Text("Ameen")
                    .font(Fonts.Bold.returnFont(size: 18))
                    .foregroundColor(Theme.whiteColor)
                
                Text(verbatim: "User.shared.email")
                    .font(Fonts.Regular.returnFont(size: 16))
                    .foregroundColor(Theme.whiteColor)
                
                Spacer()
                    .frame(height: UIScreen.main.bounds.height / 20)
                
                
            }
            .padding(.horizontal)
            
        }
    }
    
    struct ProfileStatsView: View {
        var points: Int
        var productListed: Int
        var productRequested: Int
        var body: some View {
            ZStack {
                
                HStack(spacing: 50) {
                    VStack(alignment: .center, spacing: 5) {
                        Text("\(productListed)").font(Fonts.Bold.returnFont(sizeType: .title)).foregroundColor(Theme.whiteColor)
                        Text("Listed").font(Fonts.Bold.returnFont(size: 12)).foregroundColor(Theme.greyColor)
                    }
                    .frame(width: iPhoneModel.isIPhoneSE() ? UIScreen.main.bounds.width / 4 : UIScreen.main.bounds.width / 3.4 )
                    
                    
                    VStack(alignment: .center, spacing: 5) {
                        Text("\(points)")
                            .font(Fonts.Bold.returnFont(size: 18))
                            .foregroundColor(Theme.greenTextColor)
                            .lineLimit(1)
                            .frame(width: 60)
                        Text("Points").font(Fonts.Bold.returnFont(size: 12)).foregroundColor(Theme.greyColor)
                    }
                    .frame(width: 40)
                    .background {
                        Circle()
                            .frame(width: 120, height: 120)
                            .foregroundStyle(Theme.grey)
                            .background {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 122, height: 124)
                                    .foregroundStyle(Theme.greenTextColor)
                                    .symbolEffect(.pulse.wholeSymbol, options: .speed(0.01))
                            }
                    }
                    VStack(alignment: .center, spacing: 5) {
                        Text("\(productRequested)").font(Fonts.Bold.returnFont(sizeType: .title)).foregroundColor(Theme.whiteColor)
                        Text("Requested").font(Fonts.Bold.returnFont(size: 12)).foregroundColor(Theme.greyColor)
                    }
                    .frame(width: 110)
                    
                    
                }
                .frame(height: 120)
                .background {
                    RoundedRectangle(cornerRadius: Theme.baseRadius)
                        .foregroundStyle(Theme.grey)
                        .frame(height: 80)
                }
            }
            
        }
    }
    
    struct ButtonsView: View {
        @StateObject var viewModel: ProfileViewModel
        
        var body: some View {
            ZStack {
                 RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(AmeenUIConfig.shared.colorPalette.textFieldBackgroundColor)
                VStack(spacing: 20) {
                    ForEach(viewModel.profileOptions) { option in
                        SingleProfileButton(
                            viewModel: viewModel,
                            icon: option.icon,
                            systemImageIcon: option.systemImageIcon,
                            buttonName: option.name,
                            optionType: option.type,
                            isComingSoon: option.isComingSoon)
                        .frame(height: 40)
                    }
                }.padding()
            }.padding()
            
        }
    }
    
    struct SingleProfileButton: View {
        @StateObject var viewModel = ProfileViewModel()
        var icon: String
        var systemImageIcon: Bool = false
        var buttonName: String
        var isSeperatorHidden: Bool?
        var optionType: ProfileOptions
        var isComingSoon: Bool
        
        var body: some View {
            HStack {
                if isComingSoon {
                    Button(action: {
                        
                    }, label: {
                        VStack(spacing: 20) {
                            HStack(spacing: 10){
                                Image(systemName: icon)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .padding(.trailing, 10)
                                
                                Text(buttonName)
                                    .font(Fonts.Bold.returnFont(size: 18))
                                    .foregroundColor(Theme.whiteColor)
                                Spacer()
                                ComingSoonLabel()
                                AQ.Components.Views.AQRightArrow()
                            }.padding()
                        }
                    })
                } else {
                    
                    switch optionType {
                    case .myDetails:
                        Button(action: {
                            viewModel.accountSheet.toggle()
                        }, label: {
                            VStack(spacing: 20) {
                                HStack(spacing: 10){
                                    Image(systemName: icon)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.white)
                                        .padding(.trailing, 10)
                                    
                                    Text(buttonName)
                                        .font(Fonts.Bold.returnFont(size: 18))
                                        .foregroundColor(Theme.whiteColor)
                                    Spacer()
                                    
                                    AQ.Components.Views.AQRightArrow()
                                }.padding()
                            }
                        })
                    case .feedback:
                        Button(action: {
                            viewModel.provideFeedback.toggle()
                        }, label: {
                            VStack(spacing: 20) {
                                HStack(spacing: 10){
                                    Image(systemName: icon)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.white)
                                        .padding(.trailing, 10)
                                    
                                    Text(buttonName)
                                        .font(Fonts.Bold.returnFont(size: 18))
                                        .foregroundColor(Theme.whiteColor)
                                    Spacer()
                                    
                                    AQ.Components.Views.AQRightArrow()
                                }.padding()
                            }
                        })
                    default:
                        NavigationLink (destination: destinationView(optionType)) {
                            VStack(spacing: 20) {
                                HStack(spacing: 10){
                                    if systemImageIcon {
                                        Image(systemName: icon)
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.white)
                                            .padding(.trailing, 10)
                                    } else {
                                        Image(icon, bundle: .main)
                                            .foregroundColor(.white)
                                            .padding(.trailing, 10)
                                    }
                                    Text(buttonName)
                                        .font(Fonts.Bold.returnFont(size: 18))
                                        .foregroundColor(Theme.whiteColor)
                                    Spacer()
                                    
                                    AQ.Components.Views.AQRightArrow()
                                }.padding()
                            }
                        }
                    }
                }
            }
        }
        private func destinationView(_ option: ProfileOptions) -> some View {
            switch option {
           
            case .myAddresses:
                return AnyView(AddressesView())
            case .aboutUs:
                return AnyView(AboutUsView())
            default:
                return AnyView(EmptyView())
            }
        }
    }
    
    struct Logout: View {
        @StateObject var viewModel = ProfileViewModel()
        var body: some View {
            AlertManager(title: "Logout?", message: "Are you sure you want to logout?",
                         stateImage: "logoutGhost", buttonTitle: "Confirm",
                         isLoading: viewModel.isLoading, callbackAction: viewModel.logout,
                         dismissAction: {
                viewModel.confirmLogoutAlert = false
            } )
            .presentationDetents([.height(300)])
        }
    }
    
}
