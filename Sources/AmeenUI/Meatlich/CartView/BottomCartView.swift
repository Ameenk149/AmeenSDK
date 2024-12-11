//
//  BottomCartView.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 31.10.24.
//
import SwiftUI

extension AQ.Meatlich {
    public struct BottomCartView: View {
        
        let title: String
        let action: () -> ()
        
        public init(title: String, action: @escaping () -> Void) {
            self.title = title
            self.action = action
        }
        
        public var body: some View {
            VStack {
                Spacer()
                HStack {
                    AQ.Components.AQText(
                        text: title,
                        font: AmeenUIConfig.shared.appFont.titleBold()
                    )
                    .padding()
                    Spacer()
                    AQ.Components.AQBasicButton(
                        buttonTitle: "View cart",
                        width: 100,
                        hideLoader: true,
                        action: action )
                    .padding(.horizontal)
                }
                .padding()
                
            }
            .background(.black)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
}
