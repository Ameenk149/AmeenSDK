//
//  AQCollectionView.swift
//
//
//  Created by Muhammad Ameen Khalil Qadri on 16.10.24.
//

import SwiftUI

extension AQ.Components.CollectionView {
    
    public struct BasicCollectionView<T: Identifiable, Content: View>: View {
        
        var height: CGFloat
        var width: CGFloat
        var data: [T]
        var noOfValues: Int
        let content: (T) -> Content
        var onItemTap: ((T) -> Void)?  // Closure to handle tap events
        var pageIndicator: Bool = true
        var isTabbed: Bool = true
        
        @State private var selectedTab = 0
        
        public init(
            data: [T],
            noOfValues: Int = 4,
            height: CGFloat = UIScreen.main.bounds.height * 0.7,
            width: CGFloat = UIScreen.main.bounds.width * 1,
            pageIndicator: Bool = true,
            @ViewBuilder content: @escaping (T) -> Content,
            onItemTap: ((T) -> Void)? = nil  // Initialize the tap closure
        ) {
            self.data = data
            self.noOfValues = noOfValues
            self.content = content
            self.height = height
            self.width = width
            self.onItemTap = onItemTap
            self.pageIndicator = pageIndicator
        }
        
        public var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                if isTabbed {
                    TabView(selection: $selectedTab) {
                        ForEach(Array(data.prefix(noOfValues).enumerated()), id: \.offset) { index, item in
                            VStack {
                                content(item)
                                    .onTapGesture {
                                        onItemTap?(item)  // Handle item tap event
                                    }
                                Spacer()
                            }
                            .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(width: width, height: height)
                    
                }
                if pageIndicator {
                    HStack(spacing: 20) {
                        ForEach(0..<min(noOfValues, data.count), id: \.self) { index in
                            Circle()
                                .fill(index == selectedTab ? Color.white : Color.gray)
                                .frame(width: 10, height: 10)
                        }
                    }
                    .padding()
                    .padding(.top, -30)
                }
                Spacer()
            }
        }
    }
    
    public struct BasicCollectionViewWithoutTab<T: Identifiable, Content: View>: View {
        
        @State var height: CGFloat
        let width: CGFloat
        let data: [T]
        let noOfValues: Int
        let content: (T) -> Content
        let onItemTap: ((T) -> Void)?  // Closure to handle tap events
        let pageIndicator: Bool
        let scrollDirection: Axis.Set
        let scrollDisabled: Bool
        
        @State private var selectedTab = 0
        
        public init(
            data: [T],
            noOfValues: Int = 4,
            height: CGFloat = UIScreen.main.bounds.height * 0.7,
            width: CGFloat = UIScreen.main.bounds.width * 0.9,
            pageIndicator: Bool = true,
            scrollDirection: Axis.Set = .horizontal,
            scrollDisabled: Bool = false,
            @ViewBuilder content: @escaping (T) -> Content,
            onItemTap: ((T) -> Void)? = nil  
        ) {
            self.data = data
            self.noOfValues = noOfValues
            self.content = content
            self.height = height
            self.width = width
            self.onItemTap = onItemTap
            self.scrollDirection = scrollDirection
            self.pageIndicator = pageIndicator
            self.scrollDisabled = scrollDisabled
        }
        
        public var body: some View {
            if scrollDirection == .horizontal {
                ScrollView(scrollDirection) {
                    HStack() {
                            ForEach(data.prefix(noOfValues)) { item in
                                content(item)
                                    .onTapGesture {
                                        onItemTap?(item)
                                    }
                                    .tag(item.id)
                                Spacer()
                            }
                        }
                    }
                .scrollDisabled(scrollDisabled)
                
            } else {
                
                LazyVStack(alignment: .center) {
                        
                        ForEach(data.prefix(noOfValues)) { item in
                            content(item)
                                .onTapGesture {
                                    onItemTap?(item)
                                }
                                .tag(item.id)
                               
                            Spacer()
                        }
                        Spacer()
                    }
               
                    .frame(width: width)
                
            }
        }
    }
    
    public struct BasicCollectionViewWithIndicatorOnTop<T: Identifiable, Content: View>: View {
        
        var height: CGFloat
        var width: CGFloat
        var data: [T]
        var noOfValues: Int
        let content: (Int,T) -> Content
        var onItemTap: ((T) -> Void)?  // Closure to handle tap events
        var pageIndicatorText: [String]
        let scrollDirection: Axis.Set
        
        @State private var selectedTab = 0
        
        public init(
            data: [T],
            noOfValues: Int = 4,
            height: CGFloat = UIScreen.main.bounds.height * 1,
            width: CGFloat = UIScreen.main.bounds.width * 0.9,
            pageIndicatorText: [String] = [],
            scrollDirection: Axis.Set = .horizontal,
            @ViewBuilder content: @escaping (Int,T) -> Content,
            onItemTap: ((T) -> Void)? = nil  // Initialize the tap closure
        ) {
            self.data = data
            self.noOfValues = noOfValues
            self.content = content
            self.height = height
            self.width = width
            self.onItemTap = onItemTap
            self.pageIndicatorText = pageIndicatorText
            self.scrollDirection = scrollDirection
        }
        
        public var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                
                HStack(spacing: 20) {
                    ForEach(0..<min(noOfValues, pageIndicatorText.count), id: \.self) { index in
                        VStack {
                            AQ.Components.AQText(text: pageIndicatorText[index], fontSize: 18, textColor: index == selectedTab ? Color.white : Color.gray)
                                .onTapGesture {
                                    withAnimation {
                                        selectedTab = index
                                    }
                                }
                            if index == selectedTab {
                                AQ.Components.Views.AQLine(animationValue: "\(selectedTab)", lineWidth: 25)
                            }
                        }
                    }
                }
                
                .padding(.vertical, 20)
                
                
                TabView(selection: $selectedTab) {
                    ForEach(Array(data.prefix(noOfValues).enumerated()), id: \.offset) { index, item in
                        VStack {
                            HStack {
                                content(selectedTab, item)
                                    .onTapGesture {
                                        onItemTap?(item)
                                    }
                                Spacer()
                            }
                            Spacer()
                        }
                        .tag(index)
                        
                    }
                   
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(width: width, height: height)
                .animation(.easeInOut, value: selectedTab)
                
                Spacer()
            }
        }
    }
    
    
    public struct BasicGridView<Data, Content>: View where Data: RandomAccessCollection, Data.Element: Identifiable, Content: View {
        let data: Data
        let columns: [GridItem]
        let content: (Data.Element) -> Content
        
        public init(
            data: Data,
            columns: [GridItem] = [GridItem(.flexible())],
            @ViewBuilder content: @escaping (Data.Element) -> Content
        ) {
            self.data = data
            self.columns = columns
            self.content = content
        }
        
        public var body: some View {
            LazyVGrid(columns: columns) {
                ForEach(data) { item in
                    content(item)
                }
            }
        }
    }
}

