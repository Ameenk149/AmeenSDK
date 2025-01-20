//
//  BasicSheets.swift
//
//
//  Created by Muhammad Ameen Khalil Qadri on 25.10.24.
//

import SwiftUI
import AlertToast
extension AQ.Components.Sheets {
    public struct SheetWithHeaderAndIncrementor: View {
        @State var quantity: Int
        
        // Properties for initialization
        var imageName: String
        var title: String
        var description1: String
        var description2: String
        var priceText: String
        var promoText: String
        var buttonText: String
        var buttonColor: Color
        var backgroundColor: Color
        var textColor: Color
        var previousCartValue: Int
        var fontSize: CGFloat
        var maximumStock: Int
        @State private var instructions: String = ""
        var action: (Int, String) -> ()
        
        public init(
            imageName: String = "food_image",
            title: String,
            description1: String,
            description2: String,
            quantity: Int = 1,
            previousCartValue: Int = 0,
            priceText: String,
            promoText: String,
            buttonText: String = "Add to cart",
            buttonColor: Color = Color.teal,
            backgroundColor: Color = Color(.secondarySystemBackground),
            textColor: Color = .white,
            fontSize: CGFloat = 20,
            maximumStock: Int = 10,
            action: @escaping (Int, String) -> ()
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
            self.quantity = quantity
            self.previousCartValue = previousCartValue
            self.maximumStock = maximumStock
            self.promoText = promoText
        }
        
        public var body: some View {
            VStack(spacing: 20) {
                
                // Image section
                AQ.Components.AQRemoteImage(imageName: imageName, width: UIScreen.main.bounds.width, height: 200)
                    .frame(maxWidth: .infinity)
                
                // Title and description
                VStack(alignment: .leading, spacing: 8) {
                    AQ.Components.AQText(text: title, fontSize: 25, textColor: .white)
                    
                    AQ.Components.AQText(
                        text: description1,
                        fontSize: 13,
                        textColor: AmeenUIConfig.shared.colorPalette.fontSecondaryColor
                    )
                    .frame(height: 40)
                    if promoText != priceText {
                        AQ.Components.AQText(
                            text: "Promo",
                            font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 14)
                        )
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(.red)
                        }
                        .shadow(radius: 10)
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
                .padding(.vertical)
                
                // Price and quantity selector
                HStack {
                    VStack(alignment: .leading) {
                        if promoText == priceText {
                            AQ.Components.AQText(
                                text: "\(priceText)",
                                font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: fontSize),
                                textColor: promoText != priceText ?  .white.opacity(0.7) : .white,
                                isStrikeThrough: promoText != priceText
                            )
                           
                        } else {
                            AQ.Components.AQText(
                                text: "\(priceText)",
                                font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 14),
                                textColor: promoText != priceText ?  .white.opacity(0.7) : .white,
                                isStrikeThrough: promoText != priceText
                            )
                        }
                        if promoText != priceText {
                            AQ.Components.AQText(
                                text: "\(promoText)",
                                font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: fontSize)
                            )
                        }
                       
                    }
                    .padding(.leading)
                    Spacer()
                    
                    // Quantity selector
                    HStack(spacing: 16) {
                        Button(action: {
                            if quantity > 1 {
                                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                withAnimation {
                                    quantity -= 1
                                }
                            }
                        }) {
                            Image(systemName: "minus")
                                .frame(width: 30, height: 30)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                        }
                        
                        AQ.Components.AQText(text: "\(quantity)", fontSize: fontSize, textColor: .white)
                        
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                            withAnimation {
                                if quantity + 1 <= maximumStock {
                                    quantity += 1
                                }
                            }
                        }) {
                            Image(systemName: "plus")
                                .frame(width: 30, height: 30)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                        }
                    }
                    .padding(.horizontal)
                }
                AQTextEditor(value: $instructions, placeholderText: "Add your instructions here", width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.2)
                    
               AQ.Components.AQBasicButton(
                    buttonTitle: previousCartValue > 0 ? "Update cart" : buttonText,
                    width: UIScreen.main.bounds.width * 0.9,
                    action: {
                        self.action(quantity, instructions)
                    })
                .padding(.vertical)
                
               
            }
            
            .background(backgroundColor)
        }
    }
    
    public struct DropDown <T: DropDownData>: View {
        var title: String
        var data: [T]
        @Binding var sheetControl: Bool
        var didSelectItem: (T) -> Void
        var trailingButton: Bool = false
        var trailingButtonAction: ()->() = {}
        var trailingButtonText: String = ""
        
        public init(title: String, data: [T], sheetControl: Binding<Bool>, didSelectItem: @escaping (T) -> Void) {
            self.title = title
            self.data = data
            self._sheetControl = sheetControl
            self.didSelectItem = didSelectItem
        }
        public init(
            title: String, data: [T],
            trailingButton: Bool, trailingButtonText: String, trailingButtonAction: @escaping () -> (),
            sheetControl: Binding<Bool>, didSelectItem: @escaping (T) -> Void) {
            self.title = title
            self.data = data
            self._sheetControl = sheetControl
            self.didSelectItem = didSelectItem
            self.trailingButton = trailingButton
            self.trailingButtonAction = trailingButtonAction
            self.trailingButtonText = trailingButtonText
        }
        
        public var body: some View {
            VStack {
                ZStack {
                    if title != "" {
                        Text(title)
                            .foregroundColor(.white)
                            .font(Fonts.Bold.returnFont(sizeType: .title))
                            .padding()
                        
                    }
                    if trailingButton {
                        HStack {
                            Spacer()
                            AQ.Components.AQTextButton(buttonTitle: trailingButtonText, action: trailingButtonAction)
                                .padding(.horizontal)
                        }
                    }
                }
                if data.isEmpty {
                    VStack {
                        Spacer()
                        AQ.Components.AQSystemImage(systemImage: "tray.2.fill", width: 40, height: 40, imageColor: .gray)
                            .padding()
                        Text("No data found")
                            .font(Fonts.Bold.returnFont(sizeType: .subtitle))
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
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
            }
            .presentationDetents([.fraction(0.4)])
            .background(Color.black)
            
        }
    }
    

    public struct DropDownWithPicker <T: DropDownData>: View {
        var title: String
        var data: [T]
        @Binding var sheetControl: Bool
        var didSelectItem: (String) -> Void
        var trailingButton: Bool = false
        var trailingButtonAction: () -> () = {}
        var trailingButtonText: String = ""
        
        // New state variables for date and time selection
        @State private var selectedDate = Date()
        
        public init(title: String, data: [T], sheetControl: Binding<Bool>, didSelectItem: @escaping (String) -> Void) {
            self.title = title
            self.data = data
            self._sheetControl = sheetControl
            self.didSelectItem = didSelectItem
        }

        public init(
            title: String, data: [T],
            trailingButton: Bool, trailingButtonText: String, trailingButtonAction: @escaping () -> (),
            sheetControl: Binding<Bool>, didSelectItem: @escaping (String) -> Void) {
            self.title = title
            self.data = data
            self._sheetControl = sheetControl
            self.didSelectItem = didSelectItem
            self.trailingButton = trailingButton
            self.trailingButtonAction = trailingButtonAction
            self.trailingButtonText = trailingButtonText
        }
        
        public var body: some View {
            VStack {
                ZStack {
                    if title != "" {
                        Text(title)
                            .foregroundColor(.white)
                            .font(Fonts.Bold.returnFont(sizeType: .title))
                            .padding()
                    }
                    if trailingButton {
                        HStack {
                            Spacer()
                            AQ.Components.AQTextButton(buttonTitle: trailingButtonText, action: trailingButtonAction)
                                .padding(.horizontal)
                        }
                    }
                }
                
                VStack {
                    HStack {
//                        AQ.Components.AQText(text: "Pickup date and time", font: AmeenUIConfig.shared.appFont.titleMedium())
//                        Spacer()
                        
                        DatePicker(
                            "",
                            selection: $selectedDate,
                            in: Date()...(Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()),
                            displayedComponents: .date)
                        .accentColor(.green)
                        .labelsHidden()
                        .background(Color.white)
                        .cornerRadius(10)
                      
                        DatePicker(
                            "",
                            selection: $selectedDate,
                            displayedComponents: .hourAndMinute
                        )
                        .accentColor(.green)
                        .labelsHidden()
                        .background(Color.white)
                        .cornerRadius(10)
                        
                    }
                    
                    AQ.Components.AQBasicButton(buttonTitle: "Select: \(formattedDateAndTime)") {
                        HelperFunctions.dismissKeyboard()
                        sheetControl.toggle()
                        didSelectItem("item")
                    }
                   
                    if data.isEmpty {
                        VStack {
                            Spacer()
                            AQ.Components.AQSystemImage(systemImage: "tray.2.fill", width: 40, height: 40, imageColor: .gray)
                                .padding()
                            Text("No data found")
                                .font(Fonts.Bold.returnFont(sizeType: .subtitle))
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
//                        ForEach(data, id: \.self) { item in
//                            Button {
//                                sheetControl.toggle()
//                                didSelectItem(item)
//                            } label: {
//                                HStack {
//                                    Text(item.itemName)
//                                        .font(Fonts.Bold.returnFont(sizeType: .title))
//                                    Spacer()
//                                    Image(systemName: item.icon)
//                                        .resizable()
//                                        .frame(width: 20, height: 20)
//                                }
//                                .padding(.horizontal)
//                            }
//                            .foregroundColor(.white)
//                        }
                    }
                }
                
            }
            .presentationDetents([.fraction(0.25)])
            .background(Color.black)
            .frame(maxWidth: .infinity)
        }

        // Formatted date and time for display
        private var formattedDateAndTime: String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: selectedDate)
        }
    }
    
    public struct GenericSheet<Content: View>: View {
        let title: String
        let buttonTitle: String?
        let buttonAction: (() -> Void)?
        let content: Content
        @Binding var isPresented: Bool
        
        public init(
            title: String,
            buttonTitle: String? = nil,
            isPresented: Binding<Bool>,
            buttonAction: (() -> Void)? = nil,
            @ViewBuilder content: () -> Content
        ) {
            self.title = title
            self.buttonTitle = buttonTitle
            self.buttonAction = buttonAction
            self._isPresented = isPresented
            self.content = content()
        }
        
        public var body: some View {
            VStack {
                HStack {
                    Spacer()
                    AQ.Components.AQText(text: title, font: AmeenUIConfig.shared.appFont.getSheetTitle())
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                }
                .padding()
                .overlay(content: {
                    HStack {
                        if let buttonTitle = buttonTitle, let buttonAction = buttonAction {
                            Spacer()
                            Button(action: buttonAction) {
                                AQ.Components.AQText(text: buttonTitle, font: AmeenUIConfig.shared.appFont.getSheetTitle(), textColor: AmeenUIConfig.shared.colorPalette.fontPrimaryColor)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 10)
                                    .background {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundStyle(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor)
                                    }
                            }
                            .padding(.horizontal)
                        }
                    }
                })
                
                content
            }
            .frame(maxWidth: .infinity)
            .background(Color.black)
        }
    }
    
    struct GenericSheetModifier: ViewModifier {
        let title: String
        let buttonTitle: String?
        let buttonAction: (() -> Void)?
        @Binding var isPresented: Bool
        let sheetContent: AnyView
        
        func body(content: Content) -> some View {
            content
                .background(
                    EmptyView()
                        .sheet(isPresented: $isPresented) {
                            GenericSheet(
                                title: title,
                                buttonTitle: buttonTitle,
                                isPresented: $isPresented,
                                buttonAction: buttonAction
                            ) {
                                sheetContent
                            }
                        }
                )
            
        }
    }
}

    // Extension to apply the modifier
extension View {
    public func aqSheet<SheetContent: View>(
        title: String,
        isPresented: Binding<Bool>,
        buttonTitle: String? = nil,
        buttonAction: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        let sheetContent = AnyView(content())
        return self.modifier(
            AQ.Components.Sheets.GenericSheetModifier(
                title: title,
                buttonTitle: buttonTitle,
                buttonAction: buttonAction,
                isPresented: isPresented,
                sheetContent: sheetContent
            )
        )
    }
    
    
    
    
    
}

extension View {
    public func errorSheet(
        message: String,
        isPresented: Binding<Bool>,
        buttonTitle: String,
        buttonAction: @escaping () -> Void
    ) -> some View {
        self.sheet(isPresented: isPresented) {
            BottomAlertSheet(
                message: message,
                buttonTitle: buttonTitle,
                buttonAction: buttonAction,
                errorSystemImage: "wifi.exclamationmark"
            )
            .background(.black)
        }
    }
    public func errorSheet<Item: Identifiable>(
        item: Binding<Item?>,
        buttonTitle: String,
        buttonAction: @escaping (Item) -> Void
    ) -> some View where Item: CustomStringConvertible {
        self.sheet(item: item) { item in
            BottomAlertSheet(
                message: item.description,
                buttonTitle: buttonTitle,
                buttonAction: { buttonAction(item) },
                errorSystemImage: "wifi.exclamationmark"
            )
            .background(.black)
        }
    }
}

extension View {
    public func toastView(
        title: String,
        message: String,
        isPresented: Binding<Bool>
    ) -> some View {
        AlertToast(
            displayMode: .hud,
            type:  .systemImage("exclamationmark.circle", .red),
            title: title, subTitle: message,
            style: .style(backgroundColor: Theme.grey,
                          titleColor: .red,
                          subTitleColor: Theme.whiteColor,
                          titleFont: Fonts.Bold.returnFont(sizeType: .title),
                          subTitleFont: Fonts.Medium.returnFont(sizeType: .subtitle))
        )
    }
}
