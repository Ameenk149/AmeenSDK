//
//  AccountViewModel.swift
//  GiveawayInsel
//
//  Created by Muhammad Ameen Qadri on 29.03.24.
//
import Foundation
import UIKit

import SwiftUI

class AccountViewModel: ObservableObject {
    @Published var userName: String = "Ameen"
    @Published var userEmail: String = "Ameen"
    @Published var showImagePicker = false
    @Published var profileImage: UIImage?
    
    @Published var showDeleteConfirmation: Bool = false
    @Published var showChangePasswordScreen: Bool = false
    @Published var showNewPasswordScreen: Bool = false
    @Published var showReloginConfirmation: Bool = false
    @Published var showError: Bool = false
    
    @Published var oldPassword: String = Constants.EMPTY_STRING
    @Published var newPassword: String = Constants.EMPTY_STRING
    
    init() {
      
    }
    
    func updateProfileImage(image: UIImage){
        
    }
    
    func showChangePassword() {
       
    }
    
    func reauthenticateUser(){
       
    }
    
    func changePassword() {
        
    }
    
    func deleteUserAccount() {
       
    }
    
    func logout() {
        
    }
}

