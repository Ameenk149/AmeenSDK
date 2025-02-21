//
//  CheckoutView.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 31.10.24.
//

import SwiftUI
import Combine

extension AQ.Meatlich {
    public struct DateRangeForPickup {
        let dateRange: ClosedRange<Date>
        let availableTimes: [Date]
        
        public init(dateRange: ClosedRange<Date>, availableTimes: [Date]) {
            self.dateRange = dateRange
            self.availableTimes = availableTimes
        }
    }
    
    public struct CheckoutScreen<T: CartDataProvider, A: DropDownData, D: DropDownData, P: DropDownData>: View {
        @Binding private var selectedDate: Date
        @Binding private var selectedOption: Int
        @State private var isPickupAvailable: Bool
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
        typealias Coupon = (String, String, String)
        @Binding var commitCoupon: Coupon
        
        var shopOpeningTimes: DateRangeForPickup
        
        var addresses: [A]
        var deliveryDates: [D]
        var payments: [P]
        
        var onPlaceOrder: (A?, D?, P?, Date?) -> Void
        var onItemQuantityChanged: (T.Item, Int) -> Void
        var onSelectAddAddress: () -> Void
        var onApplyCoupon: (String, @escaping ((String, String, String), Bool) -> Void) -> Void

        var viewAllPromotions: () -> Void
        var onRefer: () -> Void
        
        public init(
            cartManager: T,
            selectedOption: Binding<Int>,
            selectedDate: Binding<Date>,
            commitCoupon: Binding<(String, String, String)>,
            isPickupAvailable: Bool = false,
            shopOpeningTimes: DateRangeForPickup,
            
            addresses: [A],
            deliveryDates: [D],
            paymentMethods: [P],
            
            onSelectAddAddress: @escaping () -> Void,
            onPlaceOrder: @escaping (A?, D?, P?, Date?) -> Void,
            onItemQuantityChanged: @escaping (T.Item, Int) -> Void,
            applyCoupon: @escaping (String, @escaping ((String, String, String), Bool) -> Void) -> Void,
            viewAllPromotions: @escaping () -> Void,
            onRefer: @escaping () -> Void
            
        ) {
            self.cartManager = cartManager
            self.onPlaceOrder = onPlaceOrder
            self.onItemQuantityChanged = onItemQuantityChanged
            self.addresses = addresses
            self.deliveryDates = deliveryDates
            self.shopOpeningTimes = shopOpeningTimes
            self.payments = paymentMethods
            self.onSelectAddAddress = onSelectAddAddress
            self._selectedOption = selectedOption
            self._selectedDate = selectedDate
            self._commitCoupon = commitCoupon
            self.isPickupAvailable = isPickupAvailable
            self.onApplyCoupon = applyCoupon
            self.viewAllPromotions = viewAllPromotions
            self.onRefer = onRefer
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
                        if isPickupAvailable {
                            segmentedControl
                        }
                       
                        ItemView
                        if selectedOption == 0 {
                            SelectableItemView(title: "address", systemImage: "house.fill", buttonTitle: $selectedAddress) { selectAddress.toggle() }
                            SelectableItemView(title: "delivery date", systemImage: "calendar", buttonTitle: $selectedDeliveryDate) {  selectDeliveryDate.toggle() }
                        } else {
                            SelectableItemViewWithDateTime(
                                title: "Pickup date",
                                systemImage: "calendar",
                                buttonTitle: $selectedDeliveryDate,
                                selectedDate: $selectedDate,
                                dateRange: shopOpeningTimes.dateRange,
                                availableTimes: shopOpeningTimes.availableTimes
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
                         couponView
                        DidYouKnowReferralBox(onTapRefer: onRefer)
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
        private var couponView: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.black)
                
                VStack (alignment: .leading) {
                    HStack {
                        AQ.Components.AQText(
                            text: "Do you have a coupon?",
                            font: AmeenUIConfig.shared.appFont.subtitleBold()
                        )
                       
                        
                        Spacer()
                        AQ.Components.AQTextButton(buttonTitle: "View all promotions",
                                                   font: AmeenUIConfig.shared.appFont.subtitleBold(),
                                                   action: {
                            viewAllPromotions()
                        })
                      
                    }
                    .padding()
                    if commitCoupon.0 == "" {
                        HStack {
                            AQBasicTextField(value: $coupon, placeholderText: "Coupon", width: UIScreen.main.bounds.width * 0.6)
                            AQ.Components.AQBasicButton(
                                buttonTitle: "Apply",
                                width: UIScreen.main.bounds.width * 0.18,
                                buttonFont: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 10),
                                action: {
                                    onApplyCoupon(coupon, { coupon, isValid in
                                        if isValid {
                                            withAnimation {
                                                commitCoupon = coupon
                                            }
                                        }
                                    })
                                })
                        }
                        .padding(.leading)
                        .padding(.bottom)
                    } else {
                        
                        HStack {
                            let couponImage = "https://plus.unsplash.com/premium_photo-1670509045675-af9f249b1bbe?q=80&w=3107&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                            
                            AQ.Components.AQRemoteImage(imageName: couponImage, width: 40, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.trailing, 10)

                            VStack(alignment: .leading) {
                                AQ.Components.AQText(text: commitCoupon.0, font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 16))
                                   
                                if commitCoupon.1 != "" {
                                    AQ.Components.AQText(
                                        text: commitCoupon.1,
                                        font: AmeenUIConfig.shared.appFont.regularCustom(fontSize: 14),
                                        textColor: .gray
                                    )
                                }
                            }
                            Spacer()
                            AQ.Components.AQImageButton(systemImage: "xmark.circle.fill", width: 20, height: 20, action: {
                                withAnimation { commitCoupon.0 = "" }
                                 })
                        }
                        .padding()
                        
                        
//                        HStack {
//                            AQText
//                            AQBasicTextField(
//                                value: $coupon,
//                                placeholderText: "Coupon",
//                                width: UIScreen.main.bounds.width * 0.7)
//
//                        }
//                        .padding(.bottom)
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
            .preferredColorScheme(.dark)
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
        private func isPerStuck(for item: T.Item) -> Bool {
            cartManager.isPerStuck(for: item)
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
                            HStack {
                                if cartManager.itemOrignalPrice(for: item) > cartManager.itemPrice(for: item) {
                                    AQ.Components.AQText(
                                        text: "€\(cartManager.itemOrignalPrice(for: item))",
                                        font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 12),
                                        textColor: .gray,
                                        isStrikeThrough: true
                                    )
                                }
                                AQ.Components.AQText(
                                    text: "€\(itemPrice(for: item))\(isPerStuck(for: item) ? "/ piece" : "/ kg")",
                                    font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 12)
                                )
                            }
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
                    if selectedOption == 1 {
                        if isTimeWithinRange(date: selectedDate) == false  {
                            ToastManager.shared.showToast(title: "Shop closed at specified hour", subtitle: "Please select pickup time between 13:00 to 19:00", type: .error)
                            return
                        }
                    }
                    onPlaceOrder(sAddress, sDDate, sPaymentMethod, selectedDate)
                }
                .padding(.vertical)
            }
        }
        
        func isTimeWithinRange(date: Date) -> Bool {
            let calendar = Calendar.current
            
            // Extract the current date components
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            
            // Create the start (13:00) and end (19:00) times for the same day
            guard let startTime = calendar.date(bySettingHour: 13, minute: 0, second: 0, of: date),
                  let endTime = calendar.date(bySettingHour: 19, minute: 0, second: 0, of: date) else {
                return false
            }
            
            // Check if the given date falls within the range
            return date >= startTime && date <= endTime
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
