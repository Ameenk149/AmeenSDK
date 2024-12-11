//
//  SelectableItemView.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 07.12.24.
//
import SwiftUI

extension AQ.Meatlich {
    public struct SelectableItemView: View {
        let title: String
        let systemImage: String
        @Binding var buttonTitle: String
        let action: () -> Void
        
        public init(title: String, systemImage: String, buttonTitle: Binding<String>, action: @escaping () -> Void) {
            self.title = title
            self.systemImage = systemImage
            self._buttonTitle = buttonTitle
            self.action = action
        }
        public var body: some View {
            HStack {
                AQ.Components.AQSystemImage(systemImage: systemImage, width: 25, height: 25)
                    .padding(.horizontal)
                VStack (alignment: .leading) {
                    AQ.Components.AQText(
                        text: buttonTitle.isEmpty ? "Select \(title)" : "Change \(title)",
                        font: AmeenUIConfig.shared.appFont.titleBold()
                    )
                    if !buttonTitle.isEmpty {
                        AQ.Components.AQText(text: buttonTitle, font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 12))
                            .transition(.opacity)
                    }
                }
                Spacer()
                AQ.Components.Views.AQRightArrow()
                
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor, lineWidth: 0.5)
            )
            .onTapGesture {
                action()
            }
        }
    }
    public struct ExpandableSectionView <Content: View>: View {
        let title: String
        let systemImage: String
        let content: () -> Content
       
        @State private var isExpanded: Bool = false
        
        public init(title: String, systemImage: String, @ViewBuilder content: @escaping () -> Content) {
            self.title = title
            self.systemImage = systemImage
            self.content = content
        }
        
        public var body: some View {
            VStack {
                HStack {
                    AQ.Components.AQSystemImage(systemImage: systemImage, width: 25, height: 25)
                        .padding(.horizontal)
                    VStack(alignment: .leading) {
                        AQ.Components.AQText(
                            text: title,
                            font: AmeenUIConfig.shared.appFont.titleBold()
                        )
                    }
                    Spacer()
                    
                    if isExpanded {
                        AQ.Components.AQSystemImage(systemImage: "chevron.down" , width: 15, height: 10)
                    } else {
                        AQ.Components.AQSystemImage(systemImage: "chevron.right", width: 10, height: 15)
                    }
                }
                .padding()
                
                
                if isExpanded {
                    VStack(alignment: .leading) {
                        content()
                    }
                    .padding(.horizontal)
                    .transition(.opacity)
                }
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor, lineWidth: 0.5)
            )
        }
    }
    
    public struct ExpandableSectionViewWithTwoButtons <Content: View>: View {
        let title: String
        let systemImage: String
        let content: () -> Content
        let button1Icon: String
        let button2Icon: String
        let button1Action: ()->Void
        let button2Action: ()->Void
        
        @State private var isExpanded: Bool
        @State private var isHighlighted: Bool
        
        public init(title: String, systemImage: String, isExpanded: Bool = false, isHighlighed: Bool = false, button1Icon: String, button2Icon: String, button1Action: @escaping () -> Void, button2Action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
            self.title = title
            self.systemImage = systemImage
            self.content = content
            self.button1Icon = button1Icon
            self.button2Icon = button2Icon
            self.button1Action = button1Action
            self.button2Action = button2Action
            self.isExpanded = isExpanded
            self.isHighlighted = isHighlighed
            
            if isHighlighed {
                self.isExpanded = true
            }
          
        }
        public var body: some View {
            VStack(spacing: 0) {
                Button {
                    withAnimation {
                        isExpanded.toggle()
                    }
                } label: {
                    HStack {
                        AQ.Components.AQSystemImage(systemImage: systemImage, width: 25, height: 25)
                        AQ.Components.AQText(
                                text: title,
                                font: AmeenUIConfig.shared.appFont.titleBold()
                            )
                        Spacer()
                        AQ.Components.AQImageButton(systemImage: button1Icon, action: button1Action)
                        AQ.Components.AQImageButton(systemImage: button2Icon, backgroundColor: .red, action: button2Action)
                        if isExpanded {
                            AQ.Components.AQSystemImage(systemImage: "chevron.down" , width: 15, height: 10)
                        } else {
                            AQ.Components.AQSystemImage(systemImage: "chevron.right", width: 10, height: 15)
                        }
                    }
                }
                .padding()
               
                
                if isExpanded {
                    content()
                    .padding(.horizontal)
                    .transition(.opacity)
                }
            }
            
            
            .background(backgroundView(isHighlighted: isHighlighted))
        }
        
        @ViewBuilder
        private func backgroundView(isHighlighted: Bool) -> some View {
            if isHighlighted {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.black)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor, lineWidth: 0.5)
            }
        }
    }
    

    
    public struct ItemView: View {
        let title: String
        let systemImage: String
        let action: () -> Void
        
        public init(title: String, systemImage: String, action: @escaping () -> Void) {
            self.title = title
            self.systemImage = systemImage
            self.action = action
        }
        
        public var body: some View {
            HStack {
                AQ.Components.AQSystemImage(systemImage: systemImage, width: 25, height: 25)
                    .padding(.horizontal)
                VStack (alignment: .leading) {
                    AQ.Components.AQText(
                        text: title,
                        font: AmeenUIConfig.shared.appFont.titleBold()
                    )
                }
                Spacer()
                AQ.Components.AQSystemImage(systemImage: "chevron.right", width: 10, height: 15)
                
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor, lineWidth: 0.5)
            )
            .onTapGesture {
                action()
            }
        }
    }
}
