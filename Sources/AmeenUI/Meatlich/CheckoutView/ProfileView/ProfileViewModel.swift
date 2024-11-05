//
//  ProfileViewModel.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 01.11.24.
//


import Foundation
import SwiftUI

struct ProfileOptionModel: Identifiable {
    var id = UUID()
    let name: String
    let icon: String
    let systemImageIcon: Bool
    let type: ProfileOptions
    var isComingSoon: Bool = false
}

enum ProfileOptions: CaseIterable {
    case myDetails
    case myAddresses
    case aboutUs
    case feedback
    case logout
}

class ProfileViewModel: ObservableObject {
    
    @Published var confirmLogoutAlert = false
    @Published var accountSheet = false
    @Published var provideFeedback = false
    @Published var isLoading = false
    @Published var goTo = false
    @Published var goToDestination: Bool = false
    @Published var profileImage: UIImage? = nil
    var selectedOption: ProfileOptions = .aboutUs
    
    let profileOptions: [ProfileOptionModel] = [
        ProfileOptionModel(name: "Account", icon: "person.crop.circle.fill", systemImageIcon: true, type: .myDetails),
        ProfileOptionModel(name: "Addresses", icon: "house.fill", systemImageIcon: true, type: .myAddresses, isComingSoon: true),
        ProfileOptionModel(name: "About us", icon: "info.circle.fill", systemImageIcon: true, type: .aboutUs),
        ProfileOptionModel(name: "Provide feedback", icon: "paperplane.fill", systemImageIcon: true, type: .feedback)
    ]
    
    func confirmLogout(){
        confirmLogoutAlert = true
    }
    
    func logout() {
      
    }
    
    
}
