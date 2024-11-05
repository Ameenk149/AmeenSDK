//
//  File.swift
//
//
//  Created by Muhammad Ameen Khalil Qadri on 15.10.24.
//

import SwiftUI

public struct FontSize {
    var bigTitle: CGFloat
    var title: CGFloat
    var subtitle: CGFloat
    var regular: CGFloat
    
    public init(
        bigTitle: CGFloat = 20,
        title: CGFloat = 16,
        subtitle: CGFloat = 12,
        regular: CGFloat = 10)
    {
        self.bigTitle = bigTitle
        self.title = title
        self.subtitle = subtitle
        self.regular = regular
    }
    
}

public struct FontFamily {
    var Regular: String
    var Medium: String
    var Bold: String
    var MediumItalic: String
    
    public init(
        Regular: String = "Gilroy-Regular",
        Medium: String = "Gilroy-Medium",
        Bold: String = "Gilroy-Bold",
        MediumItalic: String = "Gilroy-MediumItalic") {
            self.Regular = Regular
            self.Medium = Medium
            self.Bold = Bold
            self.MediumItalic = MediumItalic
        }
    
}

public protocol FontWeightProtocol {
    var Regular: String { get set }
    var Medium: String { get set }
    var Bold: String { get set }
    var MediumItalic: String { get set }
}

public class FontWeight: FontWeightProtocol {
    public var Regular: String
    public var Medium: String
    public var Bold: String
    public var MediumItalic: String
    
    public init(
        Regular: String = "Gilroy-Regular",
        Medium: String = "Gilroy-Medium",
        Bold: String = "Gilroy-Bold",
        MediumItalic: String = "Gilroy-MediumItalic") {
            self.Regular = Regular
            self.Medium = Medium
            self.Bold = Bold
            self.MediumItalic = MediumItalic
        }
    
}

public struct AppFont {
    var fontSize: FontSize
    var fontFamily: FontFamily
   
    public init(fontSize: FontSize = FontSize(),
         fontFamily: FontFamily = FontFamily()) {
        self.fontSize = fontSize
        self.fontFamily = fontFamily
    }
    
    // MARK :- Regular Fonts
    public func regular() -> Font {
        return Font.custom(fontFamily.Regular, size: fontSize.regular, relativeTo: .body)
            .fallbackIfCustomFontFails(size: fontSize.regular)
    }
    
    public func titleRegular() -> Font {
        return Font.custom(fontFamily.Regular, size: fontSize.title, relativeTo: .title)
            .fallbackIfCustomFontFails(size: fontSize.title)
    }
    
    public func bigTitleRegular() -> Font {
        return Font.custom(fontFamily.Regular, size: fontSize.bigTitle, relativeTo: .largeTitle)
            .fallbackIfCustomFontFails(size: fontSize.bigTitle)
    }
    
    public func subtitleRegular() -> Font {
        return Font.custom(fontFamily.Regular, size: fontSize.subtitle, relativeTo: .subheadline)
            .fallbackIfCustomFontFails(size: fontSize.subtitle)
    }
    
    // MARK :- Medium Fonts
    public func medium() -> Font {
        return Font.custom(fontFamily.Medium, size: fontSize.regular, relativeTo: .body)
            .fallbackIfCustomFontFails(size: fontSize.regular)
    }
    
    public func titleMedium() -> Font {
        return Font.custom(fontFamily.Medium, size: fontSize.title, relativeTo: .title)
            .fallbackIfCustomFontFails(size: fontSize.title)
    }
    
    public func bigTitleMedium() -> Font {
        return Font.custom(fontFamily.Medium, size: fontSize.bigTitle, relativeTo: .largeTitle)
            .fallbackIfCustomFontFails(size: fontSize.bigTitle)
    }
    
    public func subtitleMedium() -> Font {
        return Font.custom(fontFamily.Medium, size: fontSize.subtitle, relativeTo: .subheadline)
            .fallbackIfCustomFontFails(size: fontSize.subtitle)
    }
    
    // MARK :- Bold Fonts
    public func bold() -> Font {
        return Font.custom(fontFamily.Bold, size: fontSize.regular, relativeTo: .body)
            .fallbackIfCustomFontFails(size: fontSize.regular)
    }
    
    public func titleBold() -> Font {
        return Font.custom(fontFamily.Bold, size: fontSize.title, relativeTo: .title)
            .fallbackIfCustomFontFails(size: fontSize.title)
    }
    
    public func bigTitleBold() -> Font {
        return Font.custom(fontFamily.Bold, size: fontSize.bigTitle, relativeTo: .largeTitle)
            .fallbackIfCustomFontFails(size: fontSize.bigTitle)
    }
    
    public func subtitleBold() -> Font {
        return Font.custom(fontFamily.Bold, size: fontSize.subtitle, relativeTo: .subheadline)
            .fallbackIfCustomFontFails(size: fontSize.subtitle)
    }
    
    // MARK :- Medium Italic Fonts
    public func mediumItalic() -> Font {
        return Font.custom(fontFamily.MediumItalic, size: fontSize.regular, relativeTo: .body)
            .fallbackIfCustomFontFails(size: fontSize.regular)
    }
    
    public func titleMediumItalic() -> Font {
        return Font.custom(fontFamily.MediumItalic, size: fontSize.title, relativeTo: .title)
            .fallbackIfCustomFontFails(size: fontSize.title)
    }
    
    public func bigTitleMediumItalic() -> Font {
        return Font.custom(fontFamily.MediumItalic, size: fontSize.bigTitle, relativeTo: .largeTitle)
            .fallbackIfCustomFontFails(size: fontSize.bigTitle)
    }
    
    public func subtitleMediumItalic() -> Font {
        return Font.custom(fontFamily.MediumItalic, size: fontSize.subtitle, relativeTo: .subheadline)
            .fallbackIfCustomFontFails(size: fontSize.subtitle)
    }
    
    // MARK :- Custom Fonts
    public func getButtonFont() -> Font {
        return Font.custom(fontFamily.Bold, size: 17, relativeTo: .headline)
            .fallbackIfCustomFontFails(size: 17)
    }
    
    public func boldCustom(fontSize: CGFloat) -> Font {
        return Font.custom(fontFamily.Bold, size: fontSize, relativeTo: .body)
            .fallbackIfCustomFontFails(size: fontSize)
    }
    
    public func mediumCustom(fontSize: CGFloat) -> Font {
        return Font.custom(fontFamily.Medium, size: fontSize, relativeTo: .body)
            .fallbackIfCustomFontFails(size: fontSize)
    }
    
    public func regularCustom(fontSize: CGFloat) -> Font {
        return Font.custom(fontFamily.Regular, size: fontSize, relativeTo: .body)
            .fallbackIfCustomFontFails(size: fontSize)
    }
    
    public func getSheetTitle() -> Font {
        return Font.custom(fontFamily.Bold, size: 17, relativeTo: .headline)
            .fallbackIfCustomFontFails(size: 17)
    }
}

// Extension to handle fallback font
private extension Font {
    func fallbackIfCustomFontFails(size: CGFloat) -> Font {
        if let _ = UIFont(name: "Gilroy-Regular", size: size) {
            return self
        } else {
            return .system(size: size, weight: .regular, design: .default)
        }
    }
}
