//
//  AboutUsView.swift
//  GiveawayInsel
//
//  Created by Ameen Qadri on 07.05.24.
//

import SwiftUI

struct AboutUsView: View {
    @State var toggleAnimation = false
    var body: some View {
        ZStack {
//            Theme.backgroundGradientColor
//                .fill()
//            
            VStack(spacing: 20) {
                Image("LogoWhite", bundle: .main)
                    .resizable()
                    .frame(width: 100, height: 100)
                VStack(spacing: 10) {
                    Text("Giveaway Insel")
                        .foregroundStyle(.white)
                        .font(Fonts.Bold.returnFont(sizeType: .bigTitle))
                    VStack (spacing: 0) {
                        
                        if toggleAnimation {
                            Group {
                                Text("Giveaway Insel is one of its kind giveaway platforms where you can giveaway your things to those in need of them to earn points.")
                                    .padding(.bottom, -15)
                                Text("Which then you can use to get other items such as other Giveaway products, coupons and more. Not only getting free products but also helping community and enviroment")
                            }
                            .multilineTextAlignment(.center)
                            .padding()
                            .padding(.horizontal)
                            .foregroundStyle(Theme.greyColor.opacity(0.6))
                            .font(Fonts.Bold.returnFont(sizeType: .subtitle))
                            .transition(.opacity)
                            
                        }
                        Text("Share More, Waste Less")
                            .font(Fonts.Bold.returnFont(sizeType: .title))
                            .foregroundColor(.gray)
                            
                    }
                }
            }.animation(.easeIn(duration: 0.5), value: toggleAnimation)
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                toggleAnimation.toggle()
            }
        }
    }
}

#Preview {
    AboutUsView()
}
