//
//  DidYouKnowBox.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 22.02.25.
//
import SwiftUI

public struct DidYouKnowReferralBox: View {
    var onTapRefer: () -> Void // Callback for button action

    public init(onTapRefer: @escaping () -> Void) {
        self.onTapRefer = onTapRefer
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "gift.fill") // 🎁 Gift icon for referrals
                .foregroundColor(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                .font(.title2)

            VStack(alignment: .leading, spacing: 5) {
                Text("Refer and save tons!")
                    .font(.headline)
                    .foregroundColor(.primary)

                Text("You can save upto 50% by referring your friends! Earn rewards for every successful referral.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Button(action: onTapRefer) {
                    Text("Refer & Save")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12)
            .fill(Color(.systemGray6))
            .shadow(radius: 2))
      
    }
}
