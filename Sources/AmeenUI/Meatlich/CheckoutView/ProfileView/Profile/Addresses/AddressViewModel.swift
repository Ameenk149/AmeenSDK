//
//  AddressViewModel.swift
//  GiveawayInsel
//
//  Created by Muhammad Ameen Qadri on 01.04.24.
//

import Foundation

class AddressViewModel: ObservableObject {
    @Published var addressData = [Address]()
    
    @Published var isNewAddressSheetOpen: Bool = false
    @Published var title: String = Constants.EMPTY_STRING
    @Published var addressLine1: String = Constants.EMPTY_STRING
    @Published var addressLine2: String = Constants.EMPTY_STRING
    @Published var postalCode: String = Constants.EMPTY_STRING
    @Published var city: String = Constants.EMPTY_STRING
    @Published var toastManager = ToastManager()
    
    init() {
        getAddress()
    }
    
    func addNewAddress() {
        let newAddress = Address(id: UUID().uuidString,
                                 title: self.title,
                                 addressLine1: self.addressLine1,
                                 addressLine2: self.addressLine2,
                                 postalCode: self.postalCode,
                                 city: self.city)
        addressData.append(newAddress)
       
    }
    func getAddress() {
       
    }
    func deleteAddress(addressId: String) {
        addressData.removeAll { $0.id == addressId }
    }
    func setToastManager(toastManager: ToastManager) {
        self.toastManager = toastManager
    }
    
    func openNewAddressSheet() { isNewAddressSheetOpen.toggle() }
}
