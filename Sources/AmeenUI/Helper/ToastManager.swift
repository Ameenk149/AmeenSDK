//
//  FloatingMessage.swift
//  GiveawayInsel
//
//  Created by Muhammad Ameen Qadri on 06.06.23.
//

import Foundation
import SwiftUI
import AlertToast

public class ToastManager: ObservableObject {
    @Published var showToast = false
    @Published var title = ""
    @Published var subTitle = ""
    @Published var toastType: ToastType = .warning
    
    public init(showToast: Bool = false, title: String = "", subTitle: String = "", toastType: ToastType = .warning) {
        self.showToast = showToast
        self.title = title
        self.subTitle = subTitle
        self.toastType = toastType
    }
    
    public enum ToastType {
        case warning
        case error
        case success
        case loader
    }
    func returnAlertType () -> AlertToast {
        switch toastType {
        case .warning:
            return AlertToast(
                displayMode: .hud,
                type:  .systemImage("exclamationmark.triangle", .yellow),
                title: title, subTitle: subTitle,
                style: .style(backgroundColor: Theme.grey,
                              titleColor: .yellow,
                              subTitleColor: Theme.whiteColor,
                              titleFont: Fonts.Bold.returnFont(sizeType: .title),
                              subTitleFont: Fonts.Medium.returnFont(sizeType: .subtitle))
            )
        case .error:
            return AlertToast(
                displayMode: .hud,
                type:  .systemImage("exclamationmark.circle", .red),
                title: title, subTitle: subTitle,
                style: .style(backgroundColor: Theme.grey,
                              titleColor: .red,
                              subTitleColor: Theme.whiteColor,
                              titleFont: Fonts.Bold.returnFont(sizeType: .title),
                              subTitleFont: Fonts.Medium.returnFont(sizeType: .subtitle))
            )
        case .success:
            return AlertToast(
                displayMode: .hud,
                type:   .systemImage("checkmark.circle", Theme.greenTextColor),
                title: title, subTitle: subTitle,
                style: .style(backgroundColor: Theme.grey,
                              titleColor: Theme.greenTextColor,
                              subTitleColor: Theme.whiteColor,
                              titleFont: Fonts.Bold.returnFont(sizeType: .title),
                              subTitleFont: Fonts.Medium.returnFont(sizeType: .subtitle))
            )
        case .loader:
            return AlertToast(type: .loading, title: title, subTitle: subTitle,
                              style: .style(backgroundColor: Theme.grey,
                                            titleColor: Theme.greenTextColor,
                                            subTitleColor: Theme.whiteColor,
                                            titleFont: Fonts.Bold.returnFont(sizeType: .title),
                                            subTitleFont: Fonts.Medium.returnFont(sizeType: .subtitle))
            )
        }
    }
    
    public func showToast(title: String, subtitle: String, type: ToastType) {
        showToast = true
        self.title = title
        self.subTitle = subtitle
        self.toastType = type
    }
    
    public func hideToast() {
        self.showToast = false
    }
}

public struct AlertManager: View {
    
    var title: String
    var message: String
    
    var stateImage: String?
    var buttonTitle: String
    
    @State private var offset: CGFloat = 0
    @State var isLoading: Bool
    
    var callbackAction: () -> Void
    var dismissAction:  () -> Void
    
    public var body: some View {
        ZStack {
            Rectangle().foregroundColor(Theme.grey)
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismissAction()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                            .padding(.top, 30)
                    }
                }
                Spacer()
            }.padding(.top, 0)
             .padding(.trailing, 30)
            
            VStack(spacing: 20) {
                
                if let image = stateImage {
                    Image(image)
                        .resizable()
                        .frame(width: 150, height: 150)
                    
                }
                VStack(spacing: 5) {
                    Text(title)
                        .font(Fonts.Bold.returnFont(size: 20))
                        .foregroundColor(Theme.whiteColor)
                    Text(message)
                        .font(Fonts.Medium.returnFont(size: 15))
                        .foregroundColor(Theme.greyColor)
                }
                Button {
                    isLoading = true
                    callbackAction()
                } label: {
                    HStack {
                        Text(buttonTitle)
                            .font(Fonts.Bold.returnFont(size: 20))
                            .foregroundColor(.white)
                            .padding(5)
                        
                        if isLoading {
                            ProgressView().tint(.white)
                        } else {
                            Image(systemName: "arrow.right")
                                .offset(x: offset)
                                .padding(.leading, -8)
                                .foregroundColor(.white)
                                .animation(.easeInOut(duration: 2), value: offset)
                                .onAppear {
                                    Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
                                        withAnimation {
                                            self.offset = UIScreen.main.bounds.width - 400
                                        }
                                        withAnimation(Animation.easeInOut(duration: 2.0).delay(1.0)) {
                                            self.offset = 0
                                        }
                                    }
                                }
                        }
                    } .frame(width: UIScreen.main.bounds.width - 70, height: 50)
                }.buttonStyle(.automatic)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Theme.mainTheme)
                    )
                
            }.padding()
            
        }.background(Theme.grey)
    }
}


struct AlertPopupWithTextfield: View {
    
    var title: String
    var message: String
    
    var stateImage: String?
    var buttonTitle: String
    
    var placeholderText: String
    
    @State private var offset: CGFloat = 0
    @State var isLoading: Bool
    
    
    
    @Binding var returnVal: String
    var callbackAction: () -> Void
    var dismissAction:  () -> Void
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(Theme.grey)
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismissAction()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                            .padding(.top, 30)
                    }
                }
                Spacer()
            }.padding(.top, 0)
             .padding(.trailing, 30)
            
            VStack(spacing: 20) {
                
                if let image = stateImage {
                    Image(image)
                        .resizable()
                        .frame(width: 150, height: 150)
                    
                }
                VStack(spacing: 5) {
                    Text(title)
                        .font(Fonts.Bold.returnFont(size: 20))
                        .foregroundColor(Theme.whiteColor)
                    Text(message)
                        .font(Fonts.Medium.returnFont(size: 15))
                        .foregroundColor(Theme.greyColor)
                 //   CreateTextField(modelData: TextFieldSection(name: "", title: "", placeholder: placeholderText), bindedVariable: returnVal)
                }
                Button {
                    isLoading = true
                    callbackAction()
                } label: {
                    HStack {
                        Text(buttonTitle)
                            .font(Fonts.Regular.returnFont(size: 20))
                            .foregroundColor(.white)
                            .padding(5)
                        
                        if isLoading {
                            ProgressView().tint(.white)
                        } else {
                            Image(systemName: "arrow.right")
                                .offset(x: offset)
                                .padding(.leading, -8)
                                .foregroundColor(.white)
                                .animation(.easeInOut(duration: 2), value: offset)
                                .onAppear {
                                    Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
                                        withAnimation {
                                            self.offset = UIScreen.main.bounds.width - 400
                                        }
                                        withAnimation(Animation.easeInOut(duration: 2.0).delay(1.0)) {
                                            self.offset = 0
                                        }
                                    }
                                }
                        }
                    } .frame(width: UIScreen.main.bounds.width - 70, height: 50)
                }.buttonStyle(.automatic)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Theme.mainTheme)
                    )
                
            }.padding()
            
        }.background(Theme.grey)
    }
}


private struct CreateAddProductTextField: View {
   // var modelData: TextFieldSection
    @State var bindedVariable: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text ("modelData.title")
                .foregroundColor(Theme.whiteColor)
                .font(Fonts.Medium.returnFont(size: 18))
            TextField("", text: $bindedVariable)
                .padding()
                .placeholder(when: bindedVariable.isEmpty) {
                    Text("modelData.placeholder")
                        .font(Fonts.Medium.returnFont(size: 18))
                        .foregroundColor(Color(hex: "BBBBBB"))
                        .padding(.leading, 20)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .foregroundColor(Theme.textFieldGrey)
                    
                )
                .font(Fonts.Medium.returnFont(size: 18))
                .foregroundColor(Theme.whiteColor)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .multilineTextAlignment(.leading)
                .ignoresSafeArea(.keyboard)
                .tint(.gray)
            
        }.padding()
        
    }
}
