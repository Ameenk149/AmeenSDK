//
//  AQTexts.swift
//
//
//  Created by Muhammad Ameen Khalil Qadri on 16.10.24.
//

import SwiftUI
import Foundation

extension AQ.Components {
    public struct AQText: View {
        var text: String
        var font: Font
        var fontSize: CGFloat
        var textColor: Color
        
        
        public init(text: String,
                    font: Font = AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 40),
                    fontSize: CGFloat = 40,
                    textColor: Color = AmeenUIConfig.shared.colorPalette.fontPrimaryColor
        ) {
            self.text = text
            self.font = font
            self.fontSize = fontSize
            self.textColor = textColor
            
            if fontSize != 40 {
                self.font = AmeenUIConfig.shared.appFont.mediumCustom(fontSize: fontSize)
            }
        }
        
        public var body: some View {
            Text(text)
                .font(font) // Use the stored font
                .foregroundColor(textColor)
                .shadow(radius: 10)
             
        }
    }
}
