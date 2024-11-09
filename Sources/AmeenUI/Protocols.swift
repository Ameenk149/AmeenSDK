//
//  Protocols.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 09.11.24.
//
import Foundation

public protocol ListableData: Hashable {
    var itemName: String { get }
    var itemSubtitle: String? { get }
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
   
}
public protocol CartDataProvider: ObservableObject {
    associatedtype Item: Identifiable & Hashable
    var items: [Item] { get }
   
    func itemName(for item: Item) -> String
    func itemQuantity(for item: Item) -> Int
    func itemPrice(for item: Item) -> Double
    func getTotalPriceWithTaxes() -> Double
    func getBreakdown() -> [String: Double]
}
