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
            .fallbackIfCustomFontFails(size: fontSize.regular, weight: .regular)
    }
    
    public func titleRegular() -> Font {
        return Font.custom(fontFamily.Regular, size: fontSize.title, relativeTo: .title)
            .fallbackIfCustomFontFails(size: fontSize.title, weight: .regular)
    }
    
    public func bigTitleRegular() -> Font {
        return Font.custom(fontFamily.Regular, size: fontSize.bigTitle, relativeTo: .largeTitle)
            .fallbackIfCustomFontFails(size: fontSize.bigTitle, weight: .regular)
    }
    
    public func subtitleRegular() -> Font {
        return Font.custom(fontFamily.Regular, size: fontSize.subtitle, relativeTo: .subheadline)
            .fallbackIfCustomFontFails(size: fontSize.subtitle, weight: .regular)
    }
    
    // MARK :- Medium Fonts
    public func medium() -> Font {
        return Font.custom(fontFamily.Medium, size: fontSize.regular, relativeTo: .body)
            .fallbackIfCustomFontFails(size: fontSize.regular, weight: .medium)
    }
    
    public func titleMedium() -> Font {
        return Font.custom(fontFamily.Medium, size: fontSize.title, relativeTo: .title)
            .fallbackIfCustomFontFails(size: fontSize.title, weight: .medium)
    }
    
    public func bigTitleMedium() -> Font {
        return Font.custom(fontFamily.Medium, size: fontSize.bigTitle, relativeTo: .largeTitle)
            .fallbackIfCustomFontFails(size: fontSize.bigTitle, weight: .medium)
    }
    
    public func subtitleMedium() -> Font {
        return Font.custom(fontFamily.Medium, size: fontSize.subtitle, relativeTo: .subheadline)
            .fallbackIfCustomFontFails(size: fontSize.subtitle, weight: .medium)
    }
    
    // MARK :- Bold Fonts
    public func bold() -> Font {
        return Font.custom(fontFamily.Bold, size: fontSize.regular, relativeTo: .body)
            .fallbackIfCustomFontFails(size: fontSize.regular, weight: .bold)
    }
    
    public func titleBold() -> Font {
        return Font.custom(fontFamily.Bold, size: fontSize.title, relativeTo: .title)
            .fallbackIfCustomFontFails(size: fontSize.title, weight: .bold)
    }
    
    public func bigTitleBold() -> Font {
        return Font.custom(fontFamily.Bold, size: fontSize.bigTitle, relativeTo: .largeTitle)
            .fallbackIfCustomFontFails(size: fontSize.bigTitle, weight: .bold)
    }
    
    public func subtitleBold() -> Font {
        return Font.custom(fontFamily.Bold, size: fontSize.subtitle, relativeTo: .subheadline)
            .fallbackIfCustomFontFails(size: fontSize.subtitle, weight: .bold)
    }
    
    // MARK :- Medium Italic Fonts
    public func mediumItalic() -> Font {
        return Font.custom(fontFamily.MediumItalic, size: fontSize.regular, relativeTo: .body)
            .fallbackIfCustomFontFails(size: fontSize.regular, weight: .regular)
    }
    
    public func titleMediumItalic() -> Font {
        return Font.custom(fontFamily.MediumItalic, size: fontSize.title, relativeTo: .title)
            .fallbackIfCustomFontFails(size: fontSize.title, weight: .medium)
    }
    
    public func bigTitleMediumItalic() -> Font {
        return Font.custom(fontFamily.MediumItalic, size: fontSize.bigTitle, relativeTo: .largeTitle)
            .fallbackIfCustomFontFails(size: fontSize.bigTitle, weight: .medium)
    }
    
    public func subtitleMediumItalic() -> Font {
        return Font.custom(fontFamily.MediumItalic, size: fontSize.subtitle, relativeTo: .subheadline)
            .fallbackIfCustomFontFails(size: fontSize.subtitle, weight: .medium)
    }
    
    // MARK :- Custom Fonts
    public func getButtonFont() -> Font {
        return Font.custom(fontFamily.Bold, size: 17, relativeTo: .headline)
            .fallbackIfCustomFontFails(size: 17, weight: .bold)
    }
    
    public func boldCustom(fontSize: CGFloat) -> Font {
        return Font.custom(fontFamily.Bold, size: fontSize, relativeTo: .body)
            .fallbackIfCustomFontFails(size: fontSize, weight: .bold)
    }
    
    public func mediumCustom(fontSize: CGFloat) -> Font {
        return Font.custom(fontFamily.Medium, size: fontSize, relativeTo: .body)
            .fallbackIfCustomFontFails(size: fontSize, weight: .medium)
    }
    
    public func regularCustom(fontSize: CGFloat) -> Font {
        return Font.custom(fontFamily.Regular, size: fontSize, relativeTo: .body)
            .fallbackIfCustomFontFails(size: fontSize, weight: .regular)
    }
    
    public func getSheetTitle() -> Font {
        return Font.custom(fontFamily.Bold, size: 17, relativeTo: .headline)
            .fallbackIfCustomFontFails(size: 17, weight: .bold)
    }
}

// Extension to handle fallback font
private extension Font {
    func fallbackIfCustomFontFails(size: CGFloat, weight: Weight ) -> Font {
//        if let _ = UIFont(name: "Gilroy-Regular", size: size) {
//            return self
//        } else {
            return .system(size: size, weight: weight, design: .default)
     //   }
    }
}
