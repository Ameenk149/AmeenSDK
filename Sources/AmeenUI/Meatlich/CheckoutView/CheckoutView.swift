//
//  CheckoutView.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 31.10.24.
//

import SwiftUI

public protocol CartDataProvider: ObservableObject {
    associatedtype Item: Identifiable & Hashable
    var items: [Item] { get }
    var totalPrice: Double { get }
    
    func itemName(for item: Item) -> String
    func itemQuantity(for item: Item) -> Int
    func itemPrice(for item: Item) -> Double
}

extension AQ.Meatlich {
    public struct CheckoutScreen<T: CartDataProvider, A: DropDownData, D: DropDownData, P: DropDownData>: View {
        @ObservedObject var cartManager: T
        @State var selectAddress: Bool = false
        @State var selectedAddress: String = "Change address"
        
        @State var selectDeliveryDate: Bool = false
        @State var selectedDeliveryDate: String = "Change date"
        
        @State var selectPaymentMethod: Bool = false
        @State var selectedPaymentMethod: String = "Change payment"
        
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
                    VStack (spacing: 10) {
                        ItemView
                        AddressView
                        DeliveryDateView
                        PaymentView
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
                        selectedAddress = item.itemName
                    }
            }
            .sheet(isPresented: $selectDeliveryDate) {
                AQ.Components.Sheets.DropDown(
                    title: "Select delivery date",
                    data: deliveryDates,
                    sheetControl: $selectDeliveryDate) { item in
                        selectedDeliveryDate = item.itemName
                    }
            }
            .sheet(isPresented: $selectPaymentMethod) {
                AQ.Components.Sheets.DropDown(
                    title: "Select payment method",
                    data: payments,
                    sheetControl: $selectPaymentMethod) { item in
                        selectedPaymentMethod = item.itemName
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
                    fontSize: 15
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
                HStack {
                    AQ.Components.AQText(
                        text: "Total:",
                        font: AmeenUIConfig.shared.appFont.titleBold()
                    )
                    Spacer()
                    AQ.Components.AQText(
                        text: "€\(String(format: "%.2f", cartManager.totalPrice))",
                        font: AmeenUIConfig.shared.appFont.titleBold()
                    )
                }
                .padding()
                
                AQ.Components.AQBasicButton(buttonTitle: "Place order") {
                    onPlaceOrder()
                }
                .padding(.vertical)
            }
        }
        
        private var AddressView: some View {
            VStack {
                AQ.Components.AQText(
                    text: "Delivery address",
                    font: AmeenUIConfig.shared.appFont.titleBold()
                )
                
                AQ.Components.AQTextButton(buttonTitle: selectedAddress, action: {
                    selectAddress.toggle()
                })
            }
        }
        
        private var DeliveryDateView: some View {
            VStack {
                AQ.Components.AQText(
                    text: "Delivery date",
                    font: AmeenUIConfig.shared.appFont.titleBold()
                )
               
                AQ.Components.AQTextButton(buttonTitle: selectedDeliveryDate, action: {
                    selectDeliveryDate.toggle()
                })
            }
        }
        
        private var PaymentView: some View {
            VStack {
                AQ.Components.AQText(
                    text: "Payment Method",
                    font: AmeenUIConfig.shared.appFont.titleBold()
                )
                
                AQ.Components.AQTextButton(buttonTitle: selectedPaymentMethod, action: {
                    selectPaymentMethod.toggle()
                })
            }
        }
        
    }
    
    struct QuantityControl: View {
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
        
        var body: some View {
            HStack {
                
                AQ.Components.AQImageButton(
                    systemImage: "minus.square.fill",
                    width: 25, height: 25,
                    action: decrementQuantity
                )
                
                AQBasicTextField(value: $quantity, width: UIScreen.main.bounds.width * 0.1, height: 20)
                
                
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
