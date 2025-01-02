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
                if data.count != 1 && pageIndicator {
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
//                                    .onTapGesture {
//                                        onItemTap?(item)
//                                    }
                                
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
        var width: CGFloat
        var data: [T]
        var noOfValues: Int
        let content: (Int, T) -> Content
        var onItemTap: ((T) -> Void)? // Closure to handle tap events
        var pageIndicatorText: [String]
        let scrollDirection: Axis.Set

        @State private var selectedTab = 0
        @State private var dynamicHeight: CGFloat = 100 // Default height
        @Namespace private var animationNamespace // For matched geometry effects

        public init(
            data: [T],
            noOfValues: Int = 4,
            width: CGFloat = UIScreen.main.bounds.width * 0.9,
            pageIndicatorText: [String] = [],
            scrollDirection: Axis.Set = .horizontal,
            @ViewBuilder content: @escaping (Int, T) -> Content,
            onItemTap: ((T) -> Void)? = nil // Initialize the tap closure
        ) {
            self.data = data
            self.noOfValues = noOfValues
            self.content = content
            self.width = width
            self.onItemTap = onItemTap
            self.pageIndicatorText = pageIndicatorText
            self.scrollDirection = scrollDirection
        }

        public var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                // Page indicators with animation
                HStack(spacing: 20) {
                    ForEach(0..<min(noOfValues, pageIndicatorText.count), id: \.self) { index in
                        VStack {
                            Text(pageIndicatorText[index])
                                .font(index == selectedTab ? AmeenUIConfig.shared.appFont.boldCustom(fontSize: 18) : AmeenUIConfig.shared.appFont.mediumCustom(fontSize: 18))
//                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(index == selectedTab ? .white : .gray)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                        selectedTab = index
                                    }
                                }
                            if index == selectedTab {
                                Rectangle()
                                    .frame(width: 30, height: 2)
                                    .foregroundColor(.white)
                                    .matchedGeometryEffect(id: "indicator", in: animationNamespace)
                            } else {
                                Rectangle()
                                    .frame(width: 30, height: 2)
                                    .foregroundColor(.clear)
                            }
                        }
                    }
                }
                .padding(.vertical, 20)

                // TabView with dynamic height and animation
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
                        .background(GeometryReader { geometry in
                            Color.clear
                                .onAppear {
                                    // Update height for the first appearance
                                    DispatchQueue.main.async {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            dynamicHeight = geometry.size.height
                                        }
                                    }
                                }
                                .onChange(of: selectedTab) { _ in
                                    // Smoothly update height on tab change
                                    DispatchQueue.main.async {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            dynamicHeight = geometry.size.height
                                        }
                                    }
                                }
                        })
                        .tag(index)
//                        .transition(.asymmetric(
//                            insertion: .opacity.combined(with: .move(edge: .trailing)),
//                            removal: .opacity.combined(with: .move(edge: .leading))
//                        )) // Sleek transition effect
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(width: width, height: dynamicHeight)
                .animation(.easeInOut, value: dynamicHeight) // Height animation

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

