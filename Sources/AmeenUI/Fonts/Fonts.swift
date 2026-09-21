//
//  Fonts.swift
//  GiveawayInsel
//
//  Created by Muhammad Ameen Qadri on 02.05.23.
//

import Foundation
import UIKit
import SwiftUI

enum Fonts: String {
    case Regular      = "Gilroy-Regular"
    case Medium       = "Gilroy-Medium"
    case Bold         = "Gilroy-Bold"
    case MediumItalic = "Gilroy-MediumItalic"
    
    // Rendered with SF Pro (the system font); the raw values are the legacy Gilroy names.
    var weight: Font.Weight {
        switch self {
        case .Regular:                return .regular
        case .Medium, .MediumItalic:  return .medium
        case .Bold:                   return .bold
        }
    }
    
    // case specific
    static func regularButtonFont() -> Font? {
        return .system(size: 15, weight: .bold)
    }
    func size(size: CGFloat) -> UIFont {
        let uiWeight: UIFont.Weight
        switch self {
        case .Regular:                uiWeight = .regular
        case .Medium, .MediumItalic:  uiWeight = .medium
        case .Bold:                   uiWeight = .bold
        }
        let font = UIFont.systemFont(ofSize: size, weight: uiWeight)
        guard self == .MediumItalic,
              let italic = font.fontDescriptor.withSymbolicTraits(.traitItalic) else {
            return font
        }
        return UIFont(descriptor: italic, size: size)
    }
    func returnFont(sizeType: FontSizeType) -> Font? {
        return returnFont(size: sizeType.rawValue)
    }
    func returnFont(size: CGFloat) -> Font? {
        let font = Font.system(size: size, weight: weight)
        return self == .MediumItalic ? font.italic() : font
    }
    
    enum FontSizeType: CGFloat {
        /// font-size: 20
        case bigTitle = 20
        /// font-size: 16
        case title = 16
        /// font-size: 12
        case subtitle = 12
        /// font-size: 10
        case regular = 10
    }
}


