//
//  Protocols.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 09.11.24.
//
import Foundation
import SwiftUI

public protocol TabbedData: Identifiable {
    var title: String { get }
    var cat: String { get }
}
public protocol ListableData: Hashable {
    var itemName: String { get }
    var itemSubtitle: String? { get }
    var itemSubSubtitle: String? { get }
    var caption: String? { get }
}
public protocol ButtonListableData: Hashable {
    var itemName: String { get }
    var itemSubtitle: String? { get }
    var icon: String { get }
}
public protocol TextFeildListableData {
    var fieldName: String { get }
    var fieldPlaceholder: String { get }
    var value: Binding<String> { get set }
}
public protocol FontWeightProtocol {
    var Regular: String { get set }
    var Medium: String { get set }
    var Bold: String { get set }
    var MediumItalic: String { get set }
}
public protocol DropDownData: Hashable {
    var itemName: String { get }
    var icon: String { get }
    var id: String { get }
}
public protocol CartDataProvider: ObservableObject {
    associatedtype Item: Identifiable & Hashable
    var items: [Item] { get }
    var totalPrice: Double { get }
    
    func getVendorName() -> String 
    func itemName(for item: Item) -> String
    func itemQuantity(for item: Item) -> Int
    func itemMaxQuantity(for item: Item) -> Int
    func itemPrice(for item: Item) -> Double
    func getTotalPriceWithTaxes() -> Double
    func getTotalPriceWithoutTaxes() -> Double
    func getBreakdown() -> [String: Any]
    func isPerStuck(for item: Item) -> Bool
}
