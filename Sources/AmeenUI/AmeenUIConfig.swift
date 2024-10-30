//
//  File.swift
//
//
//  Created by Muhammad Ameen Khalil Qadri on 14.10.24.
//

import Foundation
import CoreText

public class AmeenUIConfig: ObservableObject {
    @Published public var colorPalette: ColorPalette
    @Published public var projectData: ProjectData
    @Published public var appFont: AppFont
    
    
    public static let shared = AmeenUIConfig()
    
    private init() {
        self.colorPalette = ColorPalette()
        self.projectData = ProjectData()
        self.appFont = AppFont()
        loadCustomFonts()
    }
    
    public func configure(palette: ColorPalette,
                          appName: String,
                          appFont: AppFont) {
        self.colorPalette = palette
        self.projectData.appName = appName
        self.appFont = appFont
    }
    
    private func loadCustomFonts() {
        let fonts = ["Gilroy-Regular",
                     "Gilroy-Bold",
                     "Gilroy-Medium",
                     "Gilroy-MediumItalic"]
        
        fonts.forEach { fontName in
            registerFont(fontName: fontName)
        }
    }
    
    private func registerFont(fontName: String) {
        guard let fontURL = Bundle.module.url(forResource: fontName, withExtension: "ttf"),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Failed to load font \(fontName)")
        }
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            print("Error registering font: \(fontName), \(error.debugDescription)")
        }
    }
}
