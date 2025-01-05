//
//  CheckoutView.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 31.10.24.
//

import SwiftUI

extension AQ.Meatlich {
    public struct CheckoutScreen<T: CartDataProvider, A: DropDownData, D: DropDownData, P: DropDownData>: View {
       
        @State private var selectedOption: Int = 0
        private let options = ["Deliver", "Pickup"]
      
        @State var selectAddress: Bool = false
        @State var selectedAddress: String = ""
        @State var selectedAddressId: String = ""
        @State var sAddress: A?
        
        @State var selectDeliveryDate: Bool = false
        @State var selectedDeliveryDate: String = ""
        @State var selectedDeliveryDateId: String = ""
        @State var sDDate: D?
        
        @State var selectPaymentMethod: Bool = false
        @State var selectedPaymentMethod: String = ""
        @State var selectedPaymentMethodId: String = ""
        @State var sPaymentMethod: P?
        
        @ObservedObject var cartManager: T
        
        var addresses: [A]
        var deliveryDates: [D]
        var payments: [P]
        
        var onPlaceOrder: (A, D, P) -> Void
        var onItemQuantityChanged: (T.Item, Int) -> Void
        var onSelectAddAddress: () -> Void
        
        public init(
            cartManager: T,
            addresses: [A],
            deliveryDates: [D],
            paymentMethods: [P],
            onSelectAddAddress: @escaping () -> Void,
            onPlaceOrder: @escaping (A, D, P) -> Void,
            onItemQuantityChanged: @escaping (T.Item, Int) -> Void
        ) {
            self.cartManager = cartManager
            self.onPlaceOrder = onPlaceOrder
            self.onItemQuantityChanged = onItemQuantityChanged
            self.addresses = addresses
            self.deliveryDates = deliveryDates
            self.payments = paymentMethods
            self.onSelectAddAddress = onSelectAddAddress
            
            let attributesNormal: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 14, weight: .regular)
            ]
            
            let attributesSelected: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 14, weight: .bold)
            ]
            
            UISegmentedControl.appearance().setTitleTextAttributes(attributesNormal, for: .normal)
            UISegmentedControl.appearance().setTitleTextAttributes(attributesSelected, for: .selected)
            
        }
        func allSelected() -> Bool {
            return !selectedAddress.isEmpty &&
            !selectedDeliveryDate.isEmpty &&
            !selectedPaymentMethod.isEmpty
        }
        
        public var body: some View {
            VStack {
                ScrollView {
                    VStack (alignment: .leading, spacing: 10) {
                        
                        AQ.Components.AQText(
                            text: cartManager.getVendorName()
                        )
                        segmentedControl
                        ItemView
                        if selectedOption == 0 {
                            SelectableItemView(title: "address", systemImage: "house.fill", buttonTitle: $selectedAddress) { selectAddress.toggle() }
                            SelectableItemView(title: "delivery date", systemImage: "calendar", buttonTitle: $selectedDeliveryDate) {  selectDeliveryDate.toggle() }
                            SelectableItemView(title: "payment method", systemImage: "creditcard.viewfinder", buttonTitle: $selectedPaymentMethod) { selectPaymentMethod.toggle() }
                            
                        }
                        HStack {
                            AQ.Components.AQText(
                                text: "Items sub total",
                                font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 18)
                            )
                            Spacer()
                            AQ.Components.AQText(
                                text: "€\(String(format: "%.2f", cartManager.getTotalPriceWithoutTaxes()))",
                                font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 18)
                            )
                        }
                        .padding(.vertical)
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
                    trailingButton: true,
                    trailingButtonText: "Add",
                    trailingButtonAction: {
                        selectAddress.toggle()
                        onSelectAddAddress()
                    },
                    sheetControl: $selectAddress) { item in
                        withAnimation {
                            selectedAddress = item.itemName
                            selectedAddressId = item.id
                            sAddress = item
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
                            selectedDeliveryDateId = item.id
                            sDDate = item
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
                            selectedPaymentMethodId = item.id
                            sPaymentMethod = item
                        }
                    }
            }
        }
        
        private var segmentedControl: some View {
            Picker(selection: $selectedOption, label: Text("Options")) {
                ForEach(0..<options.count) { index in
                    AQ.Components.AQText(text: self.options[index], fontSize: 20)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .foregroundStyle(Color.red)
            .cornerRadius(8)
            .tint(Color.green.opacity(0.7))
        }
        
        private func itemName(for item: T.Item) -> String {
            cartManager.itemName(for: item)
        }
        
        private func itemQuantity(for item: T.Item) -> Int {
            cartManager.itemQuantity(for: item)
        }
        private func itemMaxmQuantity(for item: T.Item) -> Int {
            cartManager.itemMaxQuantity(for: item)
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
                        VStack (alignment: .leading){
                            AQ.Components.AQText(
                                text: itemName(for: item),
                                fontSize: 15
                            )
                            AQ.Components.AQText(
                                text: "Price: €\(itemPrice(for: item)) / kg",
                                font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 10)
                            )
                        }
                        
                        Spacer()
                        QuantityControl(
                            quantity: itemQuantity(for: item),
                            maximumStock: itemMaxmQuantity(for: item), onQuantityChanged: { newQuantity in
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
                AQ.Components.AQBasicButton(buttonTitle: "Order summary") {
                    if selectedAddress == ""  {
                        ToastManager.shared.showToast(title: "Error", subtitle: "Please select your address", type: .error)
                        return
                    }
                    if selectedDeliveryDate == ""  {
                        ToastManager.shared.showToast(title: "Error", subtitle: "Please select your delivery date", type: .error)
                        return
                    }
                    if selectedPaymentMethod == ""  {
                        ToastManager.shared.showToast(title: "Error", subtitle: "Please select your payment method", type: .error)
                        return
                    }
                    if let add = sAddress, let date = sDDate, let pm = sPaymentMethod {
                        onPlaceOrder(add, date, pm)
                    }
                }
                .padding(.vertical)
            }
        }
    }
    
    public struct QuantityControl: View {
        @State var quantity: Int
        var onQuantityChanged: (Int) -> Void
        @Environment(\.dismiss) private var dismiss
        var maximumStock: Int
        
        private func incrementQuantity() {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            if quantity + 1 <= maximumStock {
                quantity += 1
                onQuantityChanged(quantity)
            }
            
        }
        
        private func decrementQuantity() {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            if quantity > 0 {
                quantity -= 1
                if quantity == 0 {
                    dismiss()
                }
                onQuantityChanged(quantity)
            }
        }
        
        public init(quantity: Int, maximumStock: Int = 10, onQuantityChanged: @escaping (Int) -> Void) {
            self.quantity = quantity
            self.onQuantityChanged = onQuantityChanged
            self.maximumStock = maximumStock
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
        }
    }
    
    
}
