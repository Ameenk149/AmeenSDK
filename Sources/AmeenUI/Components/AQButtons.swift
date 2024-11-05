//
//  Buttons.swift
//
//
//  Created by Muhammad Ameen Khalil Qadri on 15.10.24.
//

import SwiftUI

extension AQ.Components {
    public struct AQBasicButton: View {
        let buttonTitle: String
        let action: () -> ()
        let width: CGFloat
        let height: CGFloat
        let fontColor: Color
        
        public init(buttonTitle: String,
                    width: CGFloat = UIScreen.main.bounds.width * 0.8,
                    fontColor: Color = AmeenUIConfig.shared.colorPalette.fontPrimaryColor,
                    height: CGFloat = 50,
                    action: @escaping ()->()) {
            self.buttonTitle = buttonTitle
            self.width = width
            self.height = height
            self.action = action
            self.fontColor = fontColor
        }
        
        public var body: some View {
            Button {
                action()
            } label: {
                Text(buttonTitle)
                    .font(AmeenUIConfig.shared.appFont.getButtonFont())
                    .foregroundColor(fontColor)
                    .padding(5)
            }
            .background(
                RoundedRectangle(cornerRadius: Theme.baseRadius)
                    .foregroundColor(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                    .opacity(0.5)
                    .frame(width: width)
                    .frame(height: height)
                    .shadow(radius: 10)
            )
            
        }
    }
    
    public struct AQTextButton: View {
        let buttonTitle: String
        let action: () -> ()
        let systemImage: String?
        let backgroundColor: Color
        let fontColor: Color
        let font: Font
        
        public init(
            buttonTitle: String,
           systemImage: String? = nil,
            backgroundColor: Color = AmeenUIConfig.shared.colorPalette.buttonPrimaryColor,
            fontColor: Color = AmeenUIConfig.shared.colorPalette.buttonPrimaryColor,
            font: Font = AmeenUIConfig.shared.appFont.getButtonFont(),
            action: @escaping () -> Void
            ) {
            self.buttonTitle = buttonTitle
            self.action = action
            self.systemImage = systemImage
            self.backgroundColor = backgroundColor
            self.fontColor = fontColor
            self.font = font
        }
        
        public var body: some View {
            HStack {
                Button {
                    action()
                } label: {
                    Text(buttonTitle)
                        .font(font)
                        .foregroundColor(fontColor)
                        .shadow(radius: 10)
                       
                    
                }
                if let systemImage = systemImage {
                    Image(systemName: systemImage)
                        .foregroundStyle(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                }
            }
        }
    }
    
    public struct AQImageButton: View {
        let systemImage: String
        let width: CGFloat
        let height: CGFloat
        
        let action: () -> ()
        
        public init(systemImage: String,
                    width: CGFloat = 30,
                    height: CGFloat = 30,
                    action: @escaping ()->()) {
            self.systemImage = systemImage
            self.action = action
            self.width = width
            self.height = height
        }
        
        public var body: some View {
            Button {
                action()
            } label: {
                Image(systemName: systemImage)
                    .resizable()
                    .foregroundStyle(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                    .frame(width: width, height: height)
                    .padding(5)
            }
        }
    }
    
    public struct AQNavigationLinkWithImage<Destination: View>: View {
        let systemImage: String
        let width: CGFloat
        let height: CGFloat
        let destination: Destination
        
        public init(systemImage: String,
                    width: CGFloat = 30,
                    height: CGFloat = 30,
                    destination: Destination) {
            self.systemImage = systemImage
            self.width = width
            self.height = height
            self.destination = destination
        }
        
        public var body: some View {
            NavigationLink(destination: destination) {
                Image(systemName: systemImage)
                    .resizable()
                    .foregroundStyle(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                    .frame(width: width, height: height)
                    .padding(5)
            }
        }
    }
    
    public struct AQImageButtonCustomImage: View {
        let image: String
        let width: CGFloat
        let height: CGFloat
        
        let action: () -> ()
        
        public init(image: String,
                    width: CGFloat = 40,
                    height: CGFloat = 40,
                    action: @escaping ()->()) {
            self.image = image
            self.action = action
            self.width = width
            self.height = height
        }
        
        public var body: some View {
            Button {
                action()
            } label: {
                Image(image)
                    .resizable()
                    .foregroundStyle(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                    .frame(width: width, height: height)
                    .padding(5)
                    .shadow(radius: 10)
            }
        }
    }
}
