//
//  CheckoutView.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 31.10.24.
//

import SwiftUI


extension AQ.Meatlich {
    public struct CheckoutScreen<T: CartDataProvider, A: DropDownData, D: DropDownData, P: DropDownData>: View {
       
        @State var selectAddress: Bool = false
        @State var selectedAddress: String = ""
        
        @State var selectDeliveryDate: Bool = false
        @State var selectedDeliveryDate: String = ""
        
        @State var selectPaymentMethod: Bool = false
        @State var selectedPaymentMethod: String = ""
        
        @ObservedObject var cartManager: T
        var addresses: [A]
        var deliveryDates: [D]
        var payments: [P]
        
        var onPlaceOrder: () -> Void
        var onItemQuantityChanged: (T.Item, Int) -> Void
        
        public init(
            cartManager: T,
            addresses: [A],
            deliveryDates: [D],
            paymentMethods: [P],
            onPlaceOrder: @escaping () -> Void,
            onItemQuantityChanged: @escaping (T.Item, Int) -> Void
            
        ) {
            self.cartManager = cartManager
            self.onPlaceOrder = onPlaceOrder
            self.onItemQuantityChanged = onItemQuantityChanged
            self.addresses = addresses
            self.deliveryDates = deliveryDates
            self.payments = paymentMethods
           
        }
        
        public var body: some View {
            VStack {
                ScrollView {
                    VStack (alignment: .leading, spacing: 10) {
                        ItemView
                        
                        SelectableItemView(title: "address", systemImage: "house.fill", buttonTitle: $selectedAddress) { selectAddress.toggle() }
                        SelectableItemView(title: "delivery date", systemImage: "calendar", buttonTitle: $selectedDeliveryDate) {  selectDeliveryDate.toggle() }
                        SelectableItemView(title: "payment method", systemImage: "creditcard.viewfinder", buttonTitle: $selectedPaymentMethod) { selectPaymentMethod.toggle() }

                        PaymentBreakdownView(breakdown: cartManager.getBreakdown(), cartManager: cartManager)
                    }
                }
                .padding()
                
                Spacer()
                TotalView
            }
            .background(AmeenUIConfig.shared.colorPalette.backgroundColor)
            .sheet(isPresented: $selectAddress) {
                AQ.Components.Sheets.DropDown(
                    title: "Select address",
                    data: addresses,
                    sheetControl: $selectAddress) { item in
                        withAnimation {
                            selectedAddress = item.itemName
                        }
                    }
            }
            .sheet(isPresented: $selectDeliveryDate) {
                AQ.Components.Sheets.DropDown(
                    title: "Select delivery date",
                    data: deliveryDates,
                    sheetControl: $selectDeliveryDate) { item in
                        withAnimation {
                            selectedDeliveryDate = item.itemName
                        }
                    }
            }
            .sheet(isPresented: $selectPaymentMethod) {
                AQ.Components.Sheets.DropDown(
                    title: "Select payment method",
                    data: payments,
                    sheetControl: $selectPaymentMethod) { item in
                        withAnimation {
                            selectedPaymentMethod = item.itemName
                        }
                    }
            }
        }
        
        private func itemName(for item: T.Item) -> String {
            cartManager.itemName(for: item)
        }
        
        private func itemQuantity(for item: T.Item) -> Int {
            cartManager.itemQuantity(for: item)
        }
        
        private func itemPrice(for item: T.Item) -> Double {
            cartManager.itemPrice(for: item)
        }
        
        private var ItemView: some View {
            VStack(alignment: .leading) {
                AQ.Components.AQText(
                    text: "Items",
                    font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 18)
                )
                
                ForEach(cartManager.items) { item in
                    HStack {
                        AQ.Components.AQText(
                            text: itemName(for: item),
                            fontSize: 15
                        )
                        Spacer()
                        QuantityControl(
                            quantity: itemQuantity(for: item),
                            onQuantityChanged: { newQuantity in
                                onItemQuantityChanged(item, newQuantity)
                            }
                        )
                        
                    }
                   
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(AmeenUIConfig.shared.colorPalette.textFieldBackgroundColor)
                    }
                    
                }
                
                
               
            }
            
        }
        
        private var TotalView: some View {
            VStack {
                AQ.Components.AQBasicButton(buttonTitle: "Place order") {
                    onPlaceOrder()
                }
                .padding(.vertical)
            }
        }
    }
    
    public struct QuantityControl: View {
        @State var quantity: Int
        var onQuantityChanged: (Int) -> Void
        
        private func incrementQuantity() {
            print("Increment button clicked")
            quantity += 1
            onQuantityChanged(quantity)
        }
        
        private func decrementQuantity() {
            print("Decrement button clicked")
            if quantity > 0 {
                quantity -= 1
                onQuantityChanged(quantity)
            }
        }
        public init(quantity: Int, onQuantityChanged: @escaping (Int) -> Void) {
            self.quantity = quantity
            self.onQuantityChanged = onQuantityChanged
        }
        public var body: some View {
            HStack {
                
                AQ.Components.AQImageButton(
                    systemImage: "minus.square.fill",
                    width: 25, height: 25,
                    action: decrementQuantity
                )
                
                AQBasicTextField(value: $quantity, width: UIScreen.main.bounds.width * 0.1)
                
                
                AQ.Components.AQImageButton(
                    systemImage: "plus.square.fill",
                    width: 25, height: 25,
                    action: incrementQuantity
                )
                
            }
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor, lineWidth: 1)
            )
        }
    }
    
    
}
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

extension AQ.Meatlich {
    
    public struct PaymentBreakdownView<T: CartDataProvider>: View {
        var breakdown: [String: Double]
        @ObservedObject var cartManager: T
        
        private var totalAmount: Double {
            breakdown.values.reduce(0, +)
        }
        public init(breakdown: [String : Double], cartManager: T) {
            self.breakdown = breakdown
            self.cartManager = cartManager
        }
        
        public var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                AQ.Components.AQText(text: "Payment breakown", font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 18))
                
                ForEach(breakdown.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                    HStack {
                        AQ.Components.AQText(text: key, fontSize: 12)
                           
                        Spacer()
                        AQ.Components.AQText(text: "\(value)", fontSize: 12)
                         
                    }
                }
                
                Divider()
                
                HStack {
                    AQ.Components.AQText(
                        text: "Total:",
                        font: AmeenUIConfig.shared.appFont.titleBold()
                    )
                    Spacer()
                    AQ.Components.AQText(
                        text: "€\(String(format: "%.2f", cartManager.getTotalPriceWithTaxes()))",
                        font: AmeenUIConfig.shared.appFont.titleBold()
                    )
                }
            }
            .padding(.vertical)
           
        }
    }
    public struct ViewOnlyPaymentBreakdownView: View {
        var breakdown: [String: Double]
        var totalPriceWithTaxes: Double
       
        public init(breakdown: [String : Double], totalPriceWithTaxes: Double) {
            self.breakdown = breakdown
            self.totalPriceWithTaxes = totalPriceWithTaxes
        }
        
        public var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(breakdown.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                    HStack {
                        AQ.Components.AQText(text: key, fontSize: 12)
                           
                        Spacer()
                        AQ.Components.AQText(text: "\(value)", fontSize: 12)
                         
                    }
                }
                
                Divider()
                
                HStack {
                    AQ.Components.AQText(
                        text: "Total:",
                        font: AmeenUIConfig.shared.appFont.titleBold()
                    )
                    Spacer()
                    AQ.Components.AQText(
                        text: "€\(String(format: "%.2f", totalPriceWithTaxes))",
                        font: AmeenUIConfig.shared.appFont.titleBold()
                    )
                }
            }
            .padding()
           
        }
    }
}
