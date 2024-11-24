//
//  AddressesView.swift
//  AmeenUI
//
//  Created by Muhammad Ameen Qadri on 31.03.24.
//

import SwiftUI

extension AQ.Meatlich {
    public struct AddressesView: View {
        @ObservedObject var viewModel = AddressViewModel()
        //   @EnvironmentObject private var toastManager: ToastManager
        
        public init() {}
        
        public var body: some View {
            ZStack {
                AmeenUIConfig.shared.colorPalette.backgroundColor
                ScrollView {
                    Spacer()
                        .frame(height: 100)
                    VStack (spacing: 20) {
                        Text("Addresses")
                            .foregroundStyle(.white)
                            .font(Fonts.Bold.returnFont(sizeType: .bigTitle))
                        
                        if viewModel.addressData.isEmpty {
                            Spacer()
                                .frame(height: 150)
                            EmptyState(image: Image(systemName: "house.lodge.fill"),
                                       imageColor: .white,
                                       title: "No addresses",
                                       message: "Please add new address from the button below",
                                       imageWidth: 70)
                            .padding(.vertical)
                            .padding(.top, 10)
                            
                        } else {
                            LazyVStack (spacing: -20) {
                                ForEach(viewModel.addressData) { address in
                                    AddressCell(address: address, action: {
                                        viewModel.deleteAddress(addressId: address.id)
                                    })
                                    .frame(height: 100)
                                    .transition(.slide)
                                }
                            }
                        }
                        
                        AQ.Components.AQBasicButton(buttonTitle: "Add new address", width: UIScreen.main.bounds.width * 0.6) {
                            viewModel.openNewAddressSheet()
                        }
                        
                    }
                    
                }
            }
            .onAppear {
                // viewModel.setToastManager(toastManager: toastManager)
            }
            .ignoresSafeArea()
            .aqSheet(title: "Add your address", isPresented: $viewModel.isNewAddressSheetOpen) {
                AddNewAddressSheet(viewModel: viewModel)
            }
            
            //            .toast(isPresenting: $viewModel.toastManager.showToast){
            //                return  viewModel.toastManager.returnAlertType()
            //            }
        }
    }
    private struct AddressCell: View {
        var address: Address
        var action: () -> ()
        var body: some View {
            NavigationLink {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: Theme.baseRadius)
                        .foregroundStyle(Theme.textFieldGrey)
                    HStack {
                        
                        VStack (alignment: .leading, spacing: 08) {
                            Text(address.title)
                                .font(Fonts.Bold.returnFont(sizeType: .title))
                                .foregroundStyle(.white)
                            
                            Text("\(address.addressLine1), \(address.addressLine2), \(address.postalCode), \(address.city) ")
                                .font(Fonts.Bold.returnFont(sizeType: .subtitle))
                                .foregroundStyle(.gray)
                            
                        }
                        .padding()
                        Spacer()
                        Button {
                            action()
                        } label: {
                            Text("Delete")
                                .font(Fonts.Bold.returnFont(sizeType: .subtitle))
                                .foregroundStyle(.white)
                                .background {
                                    RoundedRectangle(cornerRadius: Theme.smallRadius)
                                        .foregroundStyle(Theme.errorColor)
                                        .frame(width: 60, height: 30)
                                }
                        }
                        .padding()
                        .padding(.trailing, 10)
                    }
                }
                .padding()
            }
        }
    }
    
    
    struct AddNewAddressSheet: View {
        @ObservedObject var viewModel: AddressViewModel
        
        var body: some View {
            ZStack {
                Theme.grey
                VStack {
                    Spacer()
                    VStack(spacing: 20) {
                        AQBasicTextField(value: $viewModel.title, placeholderText: "E.g Home")
                        AQBasicTextField(value: $viewModel.addressLine1, placeholderText: "E.g Franz Mehering Platz 3")
                        AQBasicTextField(value: $viewModel.addressLine2, placeholderText: "Zimmer 15")
                        AQTwoHorizontalTextField(firstValue: $viewModel.postalCode, secondValue: $viewModel.city, firstPlaceholderText: "Postal code", secondPlaceholderText: "City")
                       
                    }
                    .padding()
                    Spacer()
                    AQ.Components.AQBasicButton(buttonTitle: "Add address") {
                        viewModel.addNewAddress()
                    }
                    
                }
            }
          
            .presentationDetents([.fraction(0.45)])
        }
    }
    
}
