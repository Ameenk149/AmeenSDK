//
//  PaymentBreakdownView.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 07.12.24.
//
import SwiftUI

extension AQ.Meatlich {
    public struct PaymentBreakdownView<T: CartDataProvider>: View {
        var breakdown: [String: Any]
        @ObservedObject var cartManager: T
        
        public init(breakdown: [String : Any], cartManager: T) {
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
                        // Cast 'value' to Double before formatting
                        AQ.Components.AQText(text: String(format: "%.2f", value as? Double ?? 0.0), fontSize: 12)
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
                        text: "€\(String(format: "%.2f", cartManager.totalPrice))",
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
