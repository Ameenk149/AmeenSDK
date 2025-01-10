//
//  CheckoutView.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 31.10.24.
//

import SwiftUI

extension AQ.Meatlich {
    public struct CheckoutScreen<T: CartDataProvider, A: DropDownData, D: DropDownData, P: DropDownData>: View {
       
        @Binding private var selectedDate: Date
        @Binding private var selectedOption: Int
        private let options = ["Delivery", "Pickup"]
      
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
        
        @State var coupon: String = ""
        @State var commitCoupon: String = ""
        
        var addresses: [A]
        var deliveryDates: [D]
        var payments: [P]
        
        var onPlaceOrder: (A?, D?, P?, Date?) -> Void
        var onItemQuantityChanged: (T.Item, Int) -> Void
        var onSelectAddAddress: () -> Void
        
        public init(
            cartManager: T,
            selectedOption: Binding<Int>,
            selectedDate: Binding<Date>,
            addresses: [A],
            deliveryDates: [D],
            paymentMethods: [P],
            onSelectAddAddress: @escaping () -> Void,
            onPlaceOrder: @escaping (A?, D?, P?, Date?) -> Void,
            onItemQuantityChanged: @escaping (T.Item, Int) -> Void
            
        ) {
            self.cartManager = cartManager
            self.onPlaceOrder = onPlaceOrder
            self.onItemQuantityChanged = onItemQuantityChanged
            self.addresses = addresses
            self.deliveryDates = deliveryDates
            self.payments = paymentMethods
            self.onSelectAddAddress = onSelectAddAddress
            self._selectedOption = selectedOption
            self._selectedDate = selectedDate
            
            let attributesNormal: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 14, weight: .regular)
            ]
            
            let attributesSelected: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
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
                    SmallMapView()
                    VStack (alignment: .leading, spacing: 10) {
                        segmentedControl
                       
                        ItemView
                        if selectedOption == 0 {
                            SelectableItemView(title: "address", systemImage: "house.fill", buttonTitle: $selectedAddress) { selectAddress.toggle() }
                            SelectableItemView(title: "delivery date", systemImage: "calendar", buttonTitle: $selectedDeliveryDate) {  selectDeliveryDate.toggle() }
                        } else {
                            SelectableItemViewWithDateTime(
                                title: "Pickup date",
                                systemImage: "calendar",
                                buttonTitle: $selectedDeliveryDate,
                                selectedDate: $selectedDate
                            ) { }
                            
                        }
                        SelectableItemView(title: "payment method", systemImage: "creditcard.viewfinder", buttonTitle: $selectedPaymentMethod) { selectPaymentMethod.toggle() }
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
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 10)
//                                    .foregroundStyle(AmeenUIConfig.shared.colorPalette.secondaryColor)
//                            
//                            VStack (alignment: .leading) {
//                                AQ.Components.AQText(
//                                    text: "Do you have a coupon?",
//                                    font: AmeenUIConfig.shared.appFont.titleBold()
//                                )
//                                .padding([.horizontal, .top])
//                                if commitCoupon == "" {
//                                    HStack {
//                                        AQBasicTextField(value: $coupon, placeholderText: "Coupon", width: UIScreen.main.bounds.width * 0.65)
//                                        AQ.Components.AQBasicButton(
//                                            buttonTitle: "Apply",
//                                            width: UIScreen.main.bounds.width * 0.17,
//                                            buttonFont: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 10),
//                                            action: {
//                                                withAnimation {
//                                                    commitCoupon = coupon
//                                                }
//                                            })
//                                    }
//                                    .padding()
//                                } else {
//                                    HStack {
//                                        AQBasicTextField(
//                                            value: $coupon,
//                                            placeholderText: "Coupon",
//                                            width: UIScreen.main.bounds.width * 0.7)
//                                        AQ.Components.AQImageButton(systemImage: "xmark.circle.fill", width: 20, height: 20, action: {
//                                            withAnimation {
//                                                commitCoupon = ""
//                                            }
//                                        })
//                                    }
//                                    .padding()
//                                }
//                            }
//                           
//                        }
                    }
                    .padding()
                    Spacer()
                    TotalView
                        .padding(.vertical)
                }
                .scrollIndicators(.hidden)
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
                if selectedOption == 0 {
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
                } else {
                    AQ.Components.Sheets.DropDownWithPicker(
                        title: "Select delivery date",
                        data: deliveryDates,
                        sheetControl: $selectDeliveryDate) { item in
                            withAnimation {
                                selectedDeliveryDate = item
                              //  selectedDeliveryDateId = item.id
                               // sDDate = item
                            }
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
            .padding(.vertical)
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
                AQ.Components.AQBasicButton(buttonTitle: "Order summary", width: UIScreen.main.bounds.width * 0.9) {
                    if selectedAddress == "" && selectedOption == 0  {
                        ToastManager.shared.showToast(title: "Error", subtitle: "Please select your address", type: .error)
                        return
                    }
                    if selectedDeliveryDate == "" && selectedOption == 0 {
                        ToastManager.shared.showToast(title: "Error", subtitle: "Please select your delivery date", type: .error)
                        return
                    }
                    if selectedPaymentMethod == ""  {
                        ToastManager.shared.showToast(title: "Error", subtitle: "Please select your payment method", type: .error)
                        return
                    }
                    onPlaceOrder(sAddress, sDDate, sPaymentMethod, selectedDate)
//                    if let selectedPaymentMethod == 0, let add = sAddress, let date = sDDate, let pm = sPaymentMethod {
//                        onPlaceOrder(add, date, pm, "")
//                    } else if let pm = sPaymentMethod{
//                        onPlaceOrder("add", date, pm, selectedDate)
//                    }
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
