//
//  BasicList.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 09.11.24.
//
import SwiftUI

extension AQ.Components.Lists {
    
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
}
