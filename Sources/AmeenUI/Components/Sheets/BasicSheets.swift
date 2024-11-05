//
//  BasicSheets.swift
//
//
//  Created by Muhammad Ameen Khalil Qadri on 25.10.24.
//

import SwiftUI
extension AQ.Components.Sheets {
    public struct SheetWithHeaderAndIncrementor: View {
        @State private var quantity: Int = 1
        
        // Properties for initialization
        var imageName: String
        var title: String
        var description1: String
        var description2: String
        var priceText: String
        var buttonText: String
        var buttonColor: Color
        var backgroundColor: Color
        var textColor: Color
        var fontSize: CGFloat
        var action: (Int) -> ()
        
        public init(
            imageName: String = "food_image",
            title: String,
            description1: String,
            description2: String,
            priceText: String,
            buttonText: String = "Add to cart",
            buttonColor: Color = Color.teal,
            backgroundColor: Color = Color(.secondarySystemBackground),
            textColor: Color = .white,
            fontSize: CGFloat = 20,
            action: @escaping (Int) -> ()
        ) {
            self.imageName = imageName
            self.title = title
            self.description1 = description1
            self.description2 = description2
            self.priceText = priceText
            self.buttonText = buttonText
            self.buttonColor = buttonColor
            self.backgroundColor = backgroundColor
            self.textColor = textColor
            self.fontSize = fontSize
            self.action = action
        }
        
        public var body: some View {
            VStack(spacing: 20) {
                
                // Image section
                AQ.Components.AQImage(imageName: imageName, width: UIScreen.main.bounds.width, height: 200)
                    .frame(maxWidth: .infinity)
                
                
                // Title and description
                VStack(alignment: .leading, spacing: 8) {
                    AQ.Components.AQText(text: title, fontSize: 25, textColor: .white)
                          
                    AQ.Components.AQText(
                        text: description1,
                        fontSize: 13,
                        textColor: AmeenUIConfig.shared.colorPalette.fontSecondaryColor
                    )
                   
                }
                .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                .padding(.vertical)
                
                // Price and quantity selector
                HStack {
                    AQ.Components.AQText(
                        text: "€\(priceText) / kg",
                        font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: fontSize),
                        textColor: .white)
                    .padding(.horizontal)
                    Spacer()
                    
                    // Quantity selector
                    HStack(spacing: 16) {
                        Button(action: {
                            if quantity > 1 {
                                quantity -= 1
                            }
                        }) {
                            Image(systemName: "minus")
                                .frame(width: 30, height: 30)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                        }
                        
                        AQ.Components.AQText(text: "\(quantity)", fontSize: fontSize, textColor: .white)
                        
                        Button(action: {
                            quantity += 1
                        }) {
                            Image(systemName: "plus")
                                .frame(width: 30, height: 30)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                        }
                    }
                    .padding()
                }
                
                
                // Add to cart button
                AQ.Components.AQBasicButton(
                    buttonTitle: buttonText,
                    width: UIScreen.main.bounds.width * 0.9,
                    action: {
                        self.action(quantity)
                    })
                    .padding(.vertical)
                
                Spacer()
                
            }
            .background(backgroundColor)
        }
    }
    
    public struct DropDown <T: DropDownData>: View {
        var title: String
        var data: [T]
        @Binding var sheetControl: Bool
        var didSelectItem: (T) -> Void
        
        public init(title: String, data: [T], sheetControl: Binding<Bool>, didSelectItem: @escaping (T) -> Void) {
            self.title = title
            self.data = data
            self._sheetControl = sheetControl
            self.didSelectItem = didSelectItem
        }
        
        public var body: some View {
            VStack {
                Text(title)
                    .foregroundColor(.white) // Change the title text color to red
                    .font(Fonts.Bold.returnFont(sizeType: .title))
                    .padding()
                
                List(data, id: \.self) { add in
                    Button {
                       
                            sheetControl.toggle()
                            didSelectItem(add)
                       
                    } label: {
                        HStack {
                            Text(add.itemName)
                                .font(Fonts.Bold.returnFont(sizeType: .title))
                            Spacer()
                            Image(systemName: add.icon)
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                        }
                        .padding(.horizontal)
                    }
                    .listRowBackground(Color.clear)
                    .foregroundColor(.white)
                    
                }
                .listStyle(.plain)
                .font(Fonts.Bold.returnFont(sizeType: .title))
            }
            .presentationDetents([.fraction(0.4)])
            .background(Color.black)
            
        }
    }
    
    public struct GenericSheet<Content: View>: View {
        let title: String
        let content: Content
        @Binding var isPresented: Bool

        public init(title: String, isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
            self.title = title
            self._isPresented = isPresented
            self.content = content()
        }
        
        public var body: some View {
            VStack {
                AQ.Components.AQText(text: title, font: AmeenUIConfig.shared.appFont.getSheetTitle())
                    .padding()
                
                content
                   

            }
            .frame(maxWidth: .infinity)
            .background(.black)
            
        }
    }
    
    // Define the ViewModifier without generics
    struct GenericSheetModifier: ViewModifier {
        let title: String
        @Binding var isPresented: Bool
        let sheetContent: AnyView
        
        func body(content: Content) -> some View {
            content
                .background(
                    EmptyView()
                        .sheet(isPresented: $isPresented) {
                            GenericSheet(title: title, isPresented: $isPresented) {
                                sheetContent
                            }
                        }
                )
        }
    }

}

// Create an extension for View to apply the modifier
extension View {
    func aqSheet<SheetContent: View>(title: String, isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> SheetContent) -> some View {
        let sheetContent = AnyView(content())
        return self.modifier(AQ.Components.Sheets.GenericSheetModifier(title: title, isPresented: isPresented, sheetContent: sheetContent))
    }
}
