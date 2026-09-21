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

/// App typography. Renders SF Pro (the system font); `fontFamily` is kept for API compatibility.
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
        return .system(size: fontSize.regular, weight: .regular)
    }
    
    public func titleRegular() -> Font {
        return .system(size: fontSize.title, weight: .regular)
    }
    
    public func bigTitleRegular() -> Font {
        return .system(size: fontSize.bigTitle, weight: .regular)
    }
    
    public func subtitleRegular() -> Font {
        return .system(size: fontSize.subtitle, weight: .regular)
    }
    
    // MARK :- Medium Fonts
    public func medium() -> Font {
        return .system(size: fontSize.regular, weight: .medium)
    }
    
    public func titleMedium() -> Font {
        return .system(size: fontSize.title, weight: .medium)
    }
    
    public func bigTitleMedium() -> Font {
        return .system(size: fontSize.bigTitle, weight: .medium)
    }
    
    public func subtitleMedium() -> Font {
        return .system(size: fontSize.subtitle, weight: .medium)
    }
    
    // MARK :- Bold Fonts
    public func bold() -> Font {
        return .system(size: fontSize.regular, weight: .bold)
    }
    
    public func titleBold() -> Font {
        return .system(size: fontSize.title, weight: .bold)
    }
    
    public func bigTitleBold() -> Font {
        return .system(size: fontSize.bigTitle, weight: .bold)
    }
    
    public func subtitleBold() -> Font {
        return .system(size: fontSize.subtitle, weight: .bold)
    }
    
    // MARK :- Medium Italic Fonts
    public func mediumItalic() -> Font {
        return .system(size: fontSize.regular, weight: .regular)
    }
    
    public func titleMediumItalic() -> Font {
        return .system(size: fontSize.title, weight: .medium)
    }
    
    public func bigTitleMediumItalic() -> Font {
        return .system(size: fontSize.bigTitle, weight: .medium)
    }
    
    public func subtitleMediumItalic() -> Font {
        return .system(size: fontSize.subtitle, weight: .medium)
    }
    
    // MARK :- Custom Fonts
    public func getButtonFont() -> Font {
        return .system(size: 17, weight: .bold)
    }
    
    public func boldCustom(fontSize: CGFloat) -> Font {
        return .system(size: fontSize, weight: .bold)
    }
    
    public func mediumCustom(fontSize: CGFloat) -> Font {
        return .system(size: fontSize, weight: .medium)
    }
    
    public func regularCustom(fontSize: CGFloat) -> Font {
        return .system(size: fontSize, weight: .regular)
    }
    
    public func getSheetTitle() -> Font {
        return .system(size: 17, weight: .bold)
    }
}
