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
    
    // case specific
    static func regularButtonFont() -> Font? {
        return Font.custom("Gilroy-Bold", size: 15)
    }
    func size(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: self.rawValue, size: size) else {
            fatalError("Could not find font: \(self.rawValue)")
        }
        return font
    }
    func returnFont(sizeType: FontSizeType) -> Font? {
        return Font.custom(self.rawValue, size: sizeType.rawValue)
    }
    func returnFont(size: CGFloat) -> Font? {
        return Font.custom(self.rawValue, size: size)
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


