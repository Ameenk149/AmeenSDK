//
//  AddressModel.swift
//  GiveawayInsel
//
//  Created by Muhammad Ameen Qadri on 01.04.24.
//

import Foundation

struct Address: Identifiable, Codable {
    let id: String
    let title: String
    let addressLine1: String
    let addressLine2: String
    let postalCode: String
    let city: String
}
