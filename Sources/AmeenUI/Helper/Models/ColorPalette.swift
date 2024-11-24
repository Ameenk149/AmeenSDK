//
//  Color Palette.swift
//
//
//  Created by Muhammad Ameen Khalil Qadri on 15.10.24.
//

import SwiftUI

public struct ColorPalette {
    public var primaryColor: Color
    public var secondaryColor: Color
    public var backgroundColor: LinearGradient
    public var errorColor: Color
    public var warningColor: Color
    
    public var fontPrimaryColor: Color
    public var fontSecondaryColor: Color
    
    public var buttonPrimaryColor: Color
    public var textFieldBackgroundColor: Color
    
    public init(primaryColor: Color = .blue,
                secondaryColor: Color = .blue,
                backgroundColor: LinearGradient = Theme.backgroundGradientColor,
                errorColor: Color = .red.opacity(0.7),
                warningColor: Color = .blue,
                fontPrimaryColor: Color = .white,
                fontSecondaryColor: Color = .blue,
                buttonPrimaryColor: Color = .red,
                textFieldBackgroundColor: Color = Color(hex: "4D4C4C")
    )
    {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.backgroundColor = backgroundColor
        self.errorColor = errorColor
        self.warningColor = warningColor
        self.fontPrimaryColor = fontPrimaryColor
        self.fontSecondaryColor = fontSecondaryColor
        self.buttonPrimaryColor = buttonPrimaryColor
        self.textFieldBackgroundColor = textFieldBackgroundColor
    }
}
