//
//  BasicList.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 09.11.24.
//
import SwiftUI

extension AQ.Components.Lists {
    
    /// List of texts
    public struct BasicList <T: ListableData>: View {
        var title: String
        var data: [T]
        
        public init(title: String = "", data: [T]) {
            self.title = title
            self.data = data
        }
        
        public var body: some View {
            VStack {
                if title != "" {
                    Text(title)
                        .foregroundColor(.white) // Change the title text color to red
                        .font(Fonts.Bold.returnFont(sizeType: .title))
                        .padding()
                    
                }
                if data.isEmpty {
                    Text("Empty")
                        .font(Fonts.Bold.returnFont(sizeType: .title))
                }
                VStack {
                    ForEach(data, id: \.self) { add in
                        HStack {
                            Text(add.itemName)
                                .font(Fonts.Bold.returnFont(sizeType: .title))
                            Spacer()
                            //                            if let icon = add.icon {
                            //                                Image(systemName: icon)
                            //                                    .resizable()
                            //                                    .frame(width: 20, height: 20)
                            //                                    .padding(.horizontal)
                            //                            }
                            if let subtitle = add.itemSubtitle {
                                Text(subtitle)
                                    .font(Fonts.Bold.returnFont(sizeType: .title))
                            }
                        }
                        .listRowBackground(Color.clear)
                        .foregroundColor(.white)
                    }
                    .font(Fonts.Bold.returnFont(sizeType: .title))
                }
            }
            .padding()
        }
    }
    
    /// List of Text Buttons
    public struct ButtonsList <T: ButtonListableData>: View {
        var title: String
        var data: [T]
        var buttonActions: [() -> Void]
        
        public init(title: String = "", data: [T], buttonActions: [() -> Void]) {
            self.title = title
            self.data = data
            self.buttonActions = buttonActions
        }
        
        public var body: some View {
            VStack {
                if title != "" {
                    Text(title)
                        .foregroundColor(.white) // Change the title text color to red
                        .font(Fonts.Bold.returnFont(sizeType: .title))
                        .padding()
                    
                }
                if data.isEmpty {
                    Text("Empty")
                        .font(Fonts.Bold.returnFont(sizeType: .title))
                }
                VStack {
                    ForEach(data.indices, id: \.self) { index in
                        HStack {
                            
                            Image(systemName: data[index].icon)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.horizontal)
                            
                            Text(data[index].itemName)
                                .font(Fonts.Bold.returnFont(sizeType: .title))
                            
                            Spacer()
                            
                            AQ.Components.Views.AQRightArrow()
                        }
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .onTapGesture {
                            buttonActions[index]()
                        }
                    }
                    .font(Fonts.Bold.returnFont(sizeType: .title))
                }
            }
            .padding()
            
        }
    }
    
    public struct TextfieldList <T: TextFeildListableData>: View {
        var title: String
        var data: [T]
        
        public init(title: String = "", data: [T]) {
            self.title = title
            self.data = data
            
        }
        
        public var body: some View {
            VStack(spacing: 10) {
                if title != "" {
                    Text(title)
                        .foregroundColor(.white) // Change the title text color to red
                        .font(Fonts.Bold.returnFont(sizeType: .title))
                        .padding()
                    
                }
                if data.isEmpty {
                    Text("Empty")
                        .font(Fonts.Bold.returnFont(sizeType: .title))
                }
                VStack(spacing: 20) {
                    ForEach(data.indices, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(data[index].fieldName)
                                .font(Fonts.Bold.returnFont(sizeType: .title))
                                .foregroundColor(.white)
                            AQBasicTextField(value: data[index].value, placeholderText: data[index].fieldPlaceholder)
                            
                        }
                    }
                }
            }
            .padding()
            
            
        }
    }
    
    public struct BasicListWithButtetIcon <T: ListableData>: View {
        var title: String
        var data: [T]
        
        public init(title: String = "", data: [T]) {
            self.title = title
            self.data = data
        }
        
        public var body: some View {
            VStack {
                if title != "" {
                    Text(title)
                        .foregroundColor(.white)
                        .font(Fonts.Bold.returnFont(sizeType: .title))
                        .padding()
                    
                }
                if data.isEmpty {
                    Text("Empty")
                        .font(Fonts.Bold.returnFont(sizeType: .title))
                }
                VStack(spacing: 5) {
                    ForEach(data, id: \.self) { add in
                        HStack {
                            VStack(alignment: .leading) {
                              
                                Text(add.itemName)
                                    .font(Fonts.Bold.returnFont(sizeType: .title))
                                if let subSubtitle = add.itemSubSubtitle {
                                    HStack {
                                        Text("Qty: ")
                                            .font(Fonts.Bold.returnFont(sizeType: .subtitle))
                                            
                                        Text(subSubtitle)
                                            .font(Fonts.Bold.returnFont(sizeType: .subtitle))
                                            .padding(.horizontal)
                                            .padding(.vertical, 3)
                                            .background {
                                                RoundedRectangle(cornerRadius: 5)
                                                    .foregroundStyle(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                                            }
                                    }
                                    
                                }
                            }
                            
                            Spacer()
                           
                            if let subtitle = add.itemSubtitle {
                                Text(subtitle)
                                    .font(Fonts.Bold.returnFont(sizeType: .title))
                            }
                            
                        }
                        .padding(.vertical)
                        .listRowBackground(Color.clear)
                        .foregroundColor(.white)
                    }
                    .font(Fonts.Bold.returnFont(sizeType: .title))
                }
            }
            .padding()
        }
    }
}
