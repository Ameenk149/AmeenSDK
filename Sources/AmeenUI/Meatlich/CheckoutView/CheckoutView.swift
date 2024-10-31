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
    public struct CheckoutScreen<T: CartDataProvider>: View {
        @ObservedObject var cartManager: T
        var onPlaceOrder: () -> Void
        var onItemQuantityChanged: (T.Item, Int) -> Void
        var onRemoveItem: (T.Item) -> Void
        
        public init(
            cartManager: T,
            onPlaceOrder: @escaping () -> Void,
            onItemQuantityChanged: @escaping (T.Item, Int) -> Void,
            onRemoveItem: @escaping (T.Item) -> Void
        ) {
            self.cartManager = cartManager
            self.onPlaceOrder = onPlaceOrder
            self.onItemQuantityChanged = onItemQuantityChanged
            self.onRemoveItem = onRemoveItem
        }
        
        public var body: some View {
            VStack {
                AQ.Components.AQText(
                    text: "Checkout",
                    font: AmeenUIConfig.shared.appFont.titleBold(),
                    fontSize: 30,
                    textColor: AmeenUIConfig.shared.colorPalette.fontPrimaryColor
                )
                .padding()
                
                List {
                    ForEach(cartManager.items) { item in
                        HStack {
                            AQ.Components.AQText(
                                text: itemName(for: item),
                                fontSize: 18
                            )
                            Spacer()
                            QuantityControl(
                                quantity: itemQuantity(for: item),
                                onQuantityChanged: { newQuantity in
                                    onItemQuantityChanged(item, newQuantity)
                                }
                            )
                            AQ.Components.AQText(
                                text: "€\(String(format: "%.2f", itemPrice(for: item)))",
                                fontSize: 18
                            )
                            Button(action: {
                                onRemoveItem(item)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                
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
                
                Button(action: {
                    onPlaceOrder()
                }) {
                    AQ.Components.AQText(
                        text: "Place Order",
                        font: AmeenUIConfig.shared.appFont.titleBold(),
                        textColor: .white
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .padding()
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
    }
    
    
    struct QuantityControl: View {
        var quantity: Int
        var onQuantityChanged: (Int) -> Void
        
        var body: some View {
            HStack {
                Button(action: {
                    if quantity > 1 {
                        onQuantityChanged(quantity - 1)
                    }
                }) {
                    Image(systemName: "minus.circle")
                        .foregroundColor(.blue)
                }
                AQ.Components.AQText(
                    text: "\(quantity)",
                    fontSize: 18
                )
                .padding(.horizontal)
                Button(action: {
                    onQuantityChanged(quantity + 1)
                }) {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
