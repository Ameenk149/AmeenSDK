//
//  Helper.swift
//  GiveawayInsel
//
//  Created by Muhammad Ameen Qadri on 02.06.23.
//

import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct CreateRoundedRectangleWithBorder: View {
    enum TYPE { case withImage, withoutImage }
    var index: Int = 0
    let type: TYPE
    let itemName: String
    let itemImage: String?
    let borderColor: Color
    let foregroundColor: Color
    let tintColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: 1.5)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(foregroundColor)
                    }
                )
                .frame(width: 120, height: type == .withoutImage ? 30: 120)
            
            NavigationLink {
//                let model = ProductListingViewModel()
//                let catModel = CategoryViewModel(withSelectionIndex: index)
//                
//                ProductListingView(
//                    categoryViewModel: catModel,
//                    viewModel: model,
//                    isFromHomeView: false)
            } label: {
                ZStack {
                    if (itemImage != nil) {
                        ZStack{
                            
                            Image(systemName: itemImage ?? "cat-clothes")
                                .resizable()
                                .frame(width: 60, height: 50)
                                .foregroundColor(tintColor)
                                
                            
                            LinearBlurRectangleOnTopOfImage(width: 110, height: 120)
                            
                            VStack{
                                Spacer()
                                Text(itemName)
                                    .foregroundColor(tintColor)
                                    .font(Fonts.Bold.returnFont(sizeType: .subtitle))
                                    .padding()
                                    
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            .padding(.horizontal, 8)
            .cornerRadius(4)
            
            
        }
    }
}

@available(iOS 16.0, *)
struct CreateRoundedRectangleWithBorderColor: View {
    let borderColor: Color
    let foregroundColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: 1.5)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                        //555E51
                            .foregroundColor(foregroundColor)
                    }
                )
            
        }
    }
}

@available(iOS 16.0, *)
struct CreateHorizontalRoundedRectangleWithBorder: View {
    let itemName: String
    let itemImage: String?
    let borderColor: Color
    let foregroundColor: Color
    let tintColor: Color
    let action: (() -> ())?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Theme.smallRadius)
                .foregroundColor(foregroundColor)
               // .shadow(.drop(color: .black.opacity(0.3), radius: 8, x: 0, y: 5))
               
            Button(action: {
                    if let activeAction = action {
                        activeAction()
                    }
                }) {
                    Text(itemName)
                        .foregroundColor(tintColor)
                        .font(Fonts.Bold.returnFont(sizeType: .subtitle))
                }.padding(.vertical, 8)
            
        }
    }
}

@available(iOS 16.0, *)
struct CreateRatingStars: View {
    
    var rating: Int // 4
    var totalStars: Int = 5
    
    var body: some View {
        HStack {
            ForEach(0..<totalStars) { index in
                if index < totalStars - rating {
                    CreateStar(isColoured: false)
                }
                else {
                    CreateStar(isColoured: true)
                }
            }
        }
    }
}

@available(iOS 16.0, *)
private struct CreateStar: View {
    var isColoured :Bool
    var body: some View {
        if isColoured {
            Image(systemName: "star.fill")
                .foregroundColor(Theme.greenTextColor)
        } else {
            Image(systemName: "star")
                .foregroundColor(Theme.grey)
        }
    }
}

@available(iOS 16.0, *)
private struct CreateButton: View {
    var buttonTitle: String
    var buttonTitleFontColor: Color
    var buttonTitleFontSize: Fonts.FontSizeType
    var buttonTitlefont: Fonts
    
    var systemImage: String
    var systemTintColor : Color
    
    var foregroundColorButton: Color
    var cornerRadius: CGFloat
    var foregroundWidth: CGFloat
    var foregroundHeight: CGFloat
    
    var action: ()->()
    
    var body: some View {
        Button {
            action()
            
        } label: {
            Label {
                Text(buttonTitle)
                    .font(buttonTitlefont.returnFont(sizeType: buttonTitleFontSize))
                    .foregroundColor(buttonTitleFontColor)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .foregroundColor(foregroundColorButton)
                            .modifier(Theme.dropShadow(cornerRadius: cornerRadius))
                            .frame(width: foregroundWidth, height: foregroundHeight)
                    )
            } icon: {
                Image(systemName: systemImage)
                    .foregroundColor(systemTintColor)
            }
        }
        .frame(maxWidth: .infinity)
        
        
    }
}

enum ButtonType {
    case primary
    case secondary
    case disabled
    case comingSoon
}

@available(iOS 16.0, *)
struct CreateThemedButton: View {
    var buttonType : ButtonType
    var buttonTitle: String
    
    var systemImage: String
    
    var foregroundWidth: CGFloat
    var foregroundHeight: CGFloat
    
    var action: () -> ()
    var body: some View {
        
        switch buttonType {
                
            case .primary:   CreateButton(buttonTitle: buttonTitle, buttonTitleFontColor: Theme.whiteColor,
                                          buttonTitleFontSize: Fonts.FontSizeType.title, buttonTitlefont: .Bold,
                                          systemImage: systemImage, systemTintColor: Theme.greenTextColor,
                                          foregroundColorButton: Theme.mainTheme, cornerRadius: Theme.buttonRadius,
                                          foregroundWidth: foregroundWidth, foregroundHeight: foregroundHeight,
                                          action: action)
                
            case .secondary: CreateButton(buttonTitle: buttonTitle, buttonTitleFontColor: Theme.whiteColor, buttonTitleFontSize: Fonts.FontSizeType.title, buttonTitlefont: .Bold,
                                          systemImage: systemImage, systemTintColor: Theme.greenTextColor,
                                          foregroundColorButton: Theme.grey, cornerRadius: Theme.buttonRadius,
                                          foregroundWidth: foregroundWidth, foregroundHeight: foregroundHeight,
                                          action: action)
                
            case .disabled: CreateButton(buttonTitle: buttonTitle, buttonTitleFontColor: Theme.whiteColor, buttonTitleFontSize: Fonts.FontSizeType.title, buttonTitlefont: .Bold,
                                         systemImage: systemImage, systemTintColor: Theme.greenTextColor,
                                         foregroundColorButton: Theme.grey, cornerRadius: Theme.buttonRadius,
                                         foregroundWidth: foregroundWidth, foregroundHeight: foregroundHeight,
                                         action: action)
                
            case .comingSoon:
                ZStack {
                    CreateButton(buttonTitle: buttonTitle, buttonTitleFontColor: Theme.whiteColor, buttonTitleFontSize: Fonts.FontSizeType.title, buttonTitlefont: .Bold,
                                 systemImage: systemImage, systemTintColor: Theme.greenTextColor,
                                 foregroundColorButton: Theme.grey, cornerRadius: Theme.buttonRadius,
                                 foregroundWidth: foregroundWidth, foregroundHeight: foregroundHeight,
                                 action: {})
                    
                    Text("coming soon")
                        .font(Fonts.Bold.returnFont(sizeType: .regular))
                        .foregroundStyle(.black)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: Theme.smallRadius)
                                .foregroundStyle(.yellow)
                                //.height(20)
                                //.shadow(.drop(color: .black.opacity(0.3), radius: 8, x: 0, y: 5))
                        }
                }
                
                
        }
    }
}

@available(iOS 16.0, *)
struct CreateThemedButtonWithoutWidth: View {
    
    var buttonType : ButtonType
    var buttonTitle: String
    var systemImage: String
    var foregroundHeight: CGFloat
    var fontSize: CGFloat
    var cornerRadius: CGFloat
    var foregroundColor: Color
    var action: () -> ()
    
    var body: some View {
        
        switch buttonType {
                
            case .primary:   CreateButtonWithoutFrames(buttonTitle: buttonTitle, buttonTitleFontColor: Theme.whiteColor, buttonTitleFontSize: fontSize, buttonTitlefont: .Bold,
                                                       systemImage: systemImage, systemTintColor: Theme.greenTextColor,
                                                       foregroundColorButton: foregroundColor, cornerRadius: cornerRadius, foregroundHeight: foregroundHeight,
                                                       action: action)
                
            case .secondary: CreateButtonWithoutFrames(buttonTitle: buttonTitle, buttonTitleFontColor: Theme.whiteColor, buttonTitleFontSize: fontSize, buttonTitlefont: .Bold,
                                                       systemImage: systemImage, systemTintColor: Theme.greenTextColor,
                                                       foregroundColorButton: foregroundColor, cornerRadius: cornerRadius, foregroundHeight: foregroundHeight,
                                                       action: action)
                
            case .disabled: CreateButtonWithoutFrames(buttonTitle: buttonTitle, buttonTitleFontColor: Theme.whiteColor, buttonTitleFontSize: fontSize, buttonTitlefont: .Bold,
                                                      systemImage: systemImage, systemTintColor: Theme.greenTextColor,
                                                      foregroundColorButton: foregroundColor, cornerRadius: cornerRadius, foregroundHeight: foregroundHeight,
                                                      action: action)
                
            case .comingSoon:
                ZStack {
                    CreateButtonWithoutFrames(
                        buttonTitle: buttonTitle,
                        buttonTitleFontColor: Theme.whiteColor.opacity(0.6),
                        buttonTitleFontSize: fontSize,
                        buttonTitlefont: .Bold,
                        systemImage: systemImage,
                        systemTintColor: Theme.greenTextColor,
                        foregroundColorButton: foregroundColor,
                        cornerRadius: cornerRadius,
                        foregroundHeight: foregroundHeight,
                        action: {})
                    
                    ComingSoonLabel()
                        .offset(x: 30, y: -20)
                    
                }
        }
        
    }
    
    
}

@available(iOS 16.0, *)
private struct CreateButtonWithoutFrames: View {
    var buttonTitle: String
    var buttonTitleFontColor: Color
    var buttonTitleFontSize: CGFloat
    var buttonTitlefont: Fonts
    var systemImage: String
    var systemTintColor : Color
    var foregroundColorButton: Color
    var cornerRadius: CGFloat
    var foregroundHeight: CGFloat
    
    var action: ()->()
    
    var body: some View {
        Button {
            action()
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(foregroundColorButton).frame(height: foregroundHeight)
                HStack {
                    if systemImage != "" {Image(systemName: systemImage).foregroundColor(systemTintColor)}
                    Text(buttonTitle)
                        .font(buttonTitlefont.returnFont(size: buttonTitleFontSize))
                        .foregroundColor(buttonTitleFontColor)
                }
            }
        }
    }
}

@available(iOS 16.0, *)
struct ComingSoonLabel: View {
    var body: some View {
        Text("coming soon")
            .font(Fonts.Bold.returnFont(size: 8))
            .foregroundStyle(.black)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: Theme.smallRadius)
                    .foregroundStyle(.yellow)
                    //.height(20)
                    //.shadow(.drop(color: .black.opacity(0.3), radius: 8, x: 0, y: 5))
            }
    }
}


@available(iOS 16.0, *)
struct createAnimatedRightArrow: View {
    @State private var offset: CGFloat = 0
    
    var body: some View {
        Image(systemName: "arrow.right")
            .offset(x: offset)
            .padding(.leading, -8)
            .foregroundColor(.white)
            .animation(.easeInOut(duration: 2), value: offset)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
                    withAnimation {
                        offset = UIScreen.main.bounds.width - 400
                    }
                    withAnimation(Animation.easeInOut(duration: 2.0).delay(1.0)) {
                        offset = 0
                    }}}
    }
}

@available(iOS 16.0, *)
struct messageSheet: View {
    var title: String
    var subtitle: String
    enum messageType { case success, failure, warning }
    var type: messageType
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            switch type {
                case .success:
                    Image("happyFaces").resizable().frame(width: 206, height: 206).foregroundColor(Theme.mainTheme)
                    Text(title).font(Fonts.Bold.returnFont(sizeType: .bigTitle)).foregroundColor(Theme.greenTextColor)
                case .failure:
                    Image(systemName: "xmark.circle.fill").resizable().frame(width: 70, height: 70).foregroundColor(.red)
                    Text(title).font(Fonts.Bold.returnFont(sizeType: .bigTitle)).foregroundColor(.red)
                case .warning:
                    Image(systemName: "exclamationmark.circle.fill").resizable().frame(width: 70, height: 70).foregroundColor(.yellow)
                    Text(title).font(Fonts.Bold.returnFont(sizeType: .bigTitle)).foregroundColor(.yellow)
            }
            Text(subtitle).font(Fonts.Bold.returnFont(sizeType: .title)).foregroundColor(.white).padding(.horizontal).multilineTextAlignment(.center)
        }
    }
}


func loadImagesFromLocal(fromURLs urls: [String], completion: @escaping ([UIImage]?) -> Void) {
    var loadedImages: [UIImage] = []
    let group = DispatchGroup()
    
    for url in urls {
        group.enter()
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(url)
            URLSession.shared.dataTask(with: fileURL) { data, _, error in
                defer {
                    group.leave()
                }
                
                if let error = error {
                    //         devPrint("Error loading image: \(error)")
                } else if let data = data, let image = UIImage(data: data) {
                    loadedImages.append(image)
                }
            }.resume()
        }
    }
    
    group.notify(queue: .main) {
        completion(loadedImages)
    }
}

func saveImagesToLocal(images: [UIImage?]) -> [String] {
    var savedImageURLs = [String]()
    for (index, image) in images.enumerated() {
        if let data = image?.pngData() {
            let urlName = "productImage-\(index)"
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsDirectory.appendingPathComponent(urlName)
                do {
                    try data.write(to: fileURL)
                    savedImageURLs.append(urlName)
                    
                } catch {
                    //  devPrint("Error saving image: \(error)")
                }
            }
        }
    }
    return savedImageURLs
}

@available(iOS 16.0, *)
struct LinearBlurRectangleOnTopOfImage: View {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black]), // Set your desired colors
                    startPoint: .center,
                    endPoint: .bottom
                )
            )
            .blur(radius: 10) // Adjust the blur radius as needed
            .frame(width: width, height: height) // Set your desired width and height
    }
}

@available(iOS 16.0, *)
struct CreateEmptyImageState: View {
    var loadingMode: Bool = false
    var body: some View {
        ZStack{
            if loadingMode {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                Rectangle()
                    .foregroundColor(Theme.greyColor)
                VStack {
                    Image(systemName: "photo.stack")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                    
                    Text("No Image Attached")
                        .font(Fonts.Bold.returnFont(size: 15))
                        .foregroundColor(.gray)
                }.padding(.top, 50)
            }
        }
    }
}

@available(iOS 16.0, *)
public struct EmptyState: View {
    var image: Image
    var imageColor: Color
    var title: String
    var message: String
    var messageColor = Color.gray.opacity(0.5)
    var imageWidth = 50.0
    var imageHeight = 50.0
    public init(image: Image, imageColor: Color, title: String, message: String, messageColor: SwiftUICore.Color = Color.gray.opacity(0.5), imageWidth: Double = 50.0, imageHeight: Double = 50.0) {
        self.image = image
        self.imageColor = imageColor
        self.title = title
        self.message = message
        self.messageColor = messageColor
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
    }
    public var body: some View {
        VStack {
            image
                .resizable()
                .frame(width: imageWidth, height: imageHeight)
                .foregroundStyle(imageColor)
            
            VStack (spacing: 10) {
                Text(title)
                    .foregroundStyle(Theme.whiteColor)
                    .font(Fonts.Bold.returnFont(sizeType: .title))
                Text(message)
                    .foregroundStyle(messageColor)
                    .font(Fonts.Bold.returnFont(sizeType: .subtitle))
                    .multilineTextAlignment(.center)
            } .padding()
        }
    }
}

@available(iOS 16.0, *)
struct EmptyStateWithImageView: View {
    var image: AnyView?
    var imageColor: Color
    var title: String
    var message: String
    var messageColor = Theme.greyColor.opacity(0.5)
    var imageWidth = 50.0
    var imageHeight = 50.0
    
    var body: some View {
        VStack {
            image
            VStack (spacing: 10) {
                Text(title)
                    .foregroundStyle(Theme.whiteColor)
                    .font(Fonts.Bold.returnFont(sizeType: .title))
                Text(message)
                    .foregroundStyle(messageColor)
                    .font(Fonts.Bold.returnFont(sizeType: .subtitle))
                    .multilineTextAlignment(.center)
            } .padding()
        }
    }
}

/// A general purpose model to use when you don't need decodable models
struct GenericDataModel: Codable {}

@available(iOS 16.0, *)
public struct TwoHorizontalButtons: View {
    var titleOne: String
    var titleTwo: String
    var btnOneFontColor: Color = .white
    var btnTwoFontColor: Color = .white
    var btnOneBackgroundColor: Color = Theme.mainTheme
    var btnTwoBackgroundColor: Color = Theme.errorColor
    
    var actionOne: () -> ()
    var actionTwo: () -> ()
    public init(titleOne: String, titleTwo: String, btnOneFontColor: Color = .white, btnTwoFontColor: Color = .white, btnOneBackgroundColor: Color = .white, btnTwoBackgroundColor: Color = .black, actionOne: @escaping () -> Void, actionTwo: @escaping () -> Void) {
        self.titleOne = titleOne
        self.titleTwo = titleTwo
        self.btnOneFontColor = btnOneFontColor
        self.btnTwoFontColor = btnTwoFontColor
        self.btnOneBackgroundColor = btnOneBackgroundColor
        self.btnTwoBackgroundColor = btnTwoBackgroundColor
        self.actionOne = actionOne
        self.actionTwo = actionTwo
    }
    public var body: some View {
        HStack {
            Button {
                actionOne()
            } label: {
                Text(titleOne)
                        .font(Fonts.regularButtonFont())
                        .foregroundColor(btnOneFontColor) // Use foregroundColor instead of foregroundStyle for text
                        .padding()
                        .frame(width: UIScreen.main.bounds.width / 2.2) // Set the width here
                        .background(
                            RoundedRectangle(cornerRadius: Theme.baseRadius)
                                .foregroundColor(btnOneBackgroundColor) // Use foregroundColor instead of foregroundStyle for background
                        )
            }
            Spacer()
            Button {
                actionTwo()
            } label: {
                Text(titleTwo)
                    .font(Fonts.regularButtonFont())
                    .foregroundStyle(btnTwoFontColor)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 2.2) 
                    .background {
                        RoundedRectangle(cornerRadius: Theme.baseRadius)
                            .foregroundStyle(btnTwoBackgroundColor)
                    }
            }
            
            
        }.padding()
    }
}

@available(iOS 16.0, *)
struct TitleAndValueBar: View {
    var title: String
    var value: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Theme.baseRadius)
                .foregroundColor(Theme.grey)
            
            HStack (spacing: 0){
                Text(title)
                    .foregroundColor(Theme.whiteColor)
                    .font(Fonts.Bold.returnFont(sizeType: .title))
                
                Spacer()
                Text(value)
                    .foregroundColor(Theme.greenTextColor)
                    .font(Fonts.Bold.returnFont(sizeType: .title))
                
            }.padding()
        }
    }
}

class HelperFunctions {
    static func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

@available(iOS 16.0, *)
struct CustomAlertView<Content: View>: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let title: String
    let description: String
    
    var cancelAction: (() -> Void)?
    var cancelActionTitle: String?
    
    var primaryAction: (() -> Void)?
    var primaryActionTitle: String?
    
    var customContent: Content?
    
    init(title: String,
         description: String,
         cancelAction: (() -> Void)? = nil,
         cancelActionTitle: String? = nil,
         primaryAction: (() -> Void)? = nil,
         primaryActionTitle: String? = nil,
         customContent: Content? = EmptyView()) {
        self.title = title
        self.description = description
        self.cancelAction = cancelAction
        self.cancelActionTitle = cancelActionTitle
        self.primaryAction = primaryAction
        self.primaryActionTitle = primaryActionTitle
        self.customContent = customContent
    }
    
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .default))
                    .padding(.top)
                    .padding(.bottom, 8)
                
                Text(description)
                    .font(.system(size: 12, weight: .light, design: .default))
                    .multilineTextAlignment(.center)
                    .padding([.bottom, .trailing, .leading])
                
                customContent
                
                Divider()
                
                HStack {
                    if let cancelAction, let cancelActionTitle {
                        Button { cancelAction() } label: {
                            Text(cancelActionTitle)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        }
                    }
                    
                    if cancelActionTitle != nil && primaryActionTitle != nil {
                        Divider()
                    }
                    
                    if let primaryAction, let primaryActionTitle {
                        Button { primaryAction() } label: {
                            Text("**\(primaryActionTitle)**")
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        }
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .center)
            }
            .frame(minWidth: 0, maxWidth: 400, alignment: .center)
            .background(.ultraThickMaterial)
            .cornerRadius(10)
            .padding([.trailing, .leading], 50)
        }
        .zIndex(1)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(
            colorScheme == .dark
            ? Color(red: 0, green: 0, blue: 0, opacity: 0.4)
            : Color(red: 1, green: 1, blue: 1, opacity: 0.4)
        )
    }
}

@available(iOS 16.0, *)
public struct CreateProfileImageInitials: View {
    private var initials: String
    private var circleSize: CGFloat
    private var fontSize: CGFloat
    private var color: Color
    
    public init(name: String, circleSize: CGFloat = 80, fontSize: CGFloat = 26, color: Color = .blue) {
        self.initials = name.initials()
        self.circleSize = circleSize
        self.fontSize = fontSize
        self.color = color
    }
    public var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.black)
                .frame(width: circleSize, height: circleSize)
                .background {
                    Circle()
                        .foregroundStyle(color)
                        .frame(width: circleSize + 2, height: circleSize + 2)
                }
            
            Text(initials)
                .font(Fonts.Bold.returnFont(size: 26))
                .foregroundStyle(color)
        }.padding([.horizontal, .bottom])
    }
}

@available(iOS 16.0, *)
struct CustomDatePicker: View {
    @Binding var selectedDate: Date
    @Binding var selectedTimes: Set<Int>

    @State private var selectedDateIndex = 0
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy"
        return formatter
    }()
    
    private var dates: [Date] {
        var dates: [Date] = []
        var date = Date()
        let endDate = calendar.date(byAdding: .month, value: 2, to: date)!
        
        while date <= endDate {
            dates.append(date)
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
        
        return dates
    }
    
    private var formattedDates: [String] {
        dates.map { dateFormatter.string(from: $0) }
    }
    private let timeSlots: [String] = (0..<24).filter { $0 % 2 == 0 }.map { String(format: "%02d-%02d", $0, $0 + 2) }

    var body: some View {
        HStack(spacing: 20) {
            VStack {
                Text("Select Date")
                    .font(Fonts.Bold.returnFont(size: 18))
                    .foregroundColor(.white)
                
                Picker("", selection: $selectedDateIndex) {
                    ForEach(0..<formattedDates.count, id: \.self) { index in
                        Text(self.formattedDates[index])
                            .foregroundColor(.white)
                            .tag(index)
                    }
                }
                .labelsHidden()
                .pickerStyle(WheelPickerStyle())
                .font(Fonts.Bold.returnFont(sizeType: .title))
                .onChange(of: selectedDateIndex) { newValue in
                    selectedDate = dates[newValue]
                }
            }
            
            VStack {
                Text("Select Times")
                    .font(Fonts.Bold.returnFont(size: 18))
                    .foregroundColor(.white)
                ScrollView {
                    ForEach(0..<timeSlots.count, id: \.self) { index in
                        MultipleSelectionRow(time: timeSlots[index], isSelected: selectedTimes.contains(index)) {
                            if selectedTimes.contains(index) {
                                selectedTimes.remove(index)
                            } else {
                                selectedTimes.insert(index)
                            }
                        }
                    }
                }
                .background(Color.black)
            }
        }
        .padding()
        .background(Color.black)
    }
}

@available(iOS 16.0, *)
struct MultipleSelectionRow: View {
    var time: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.time)
                    .foregroundColor(.white)
                    .font(Fonts.Bold.returnFont(sizeType: .title))
                if self.isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                }
            }
            .frame(height: 30)
        }
        .foregroundColor(self.isSelected ? .blue : .white)
    }
}
struct CameraOptions: DropDownData {
    var id: String { "" }
    var itemName: String
    var icon: String
    var isComingSoon: Bool
}

@available(iOS 13.0, *)
struct Stepper: View {
    @Binding var bindedVariable: String
    var placeHolder: String
    var changeValue: Int = 10
    
    var body: some View {
        HStack {
            Button {
                decrement()
            } label: {
                Image(systemName: "minus.square.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Theme.whiteColor)
                 //   .shadow(.drop(color: .black.opacity(0.3), radius: 8, x: 0, y: 5))
            }

            TextField("", text: $bindedVariable, axis: .vertical)
                
                .padding()
                .placeholder(when: bindedVariable.isEmpty) {
                    Text(placeHolder)
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
                .multilineTextAlignment(.center)
                .ignoresSafeArea(.keyboard)
                .tint(.gray)
            
            Button {
                increment()
            } label: {
                Image(systemName: "plus.app.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Theme.whiteColor)
                  //  .shadow(.drop(color: .black.opacity(0.3), radius: 8, x: 0, y: 5))
            }
            
        }
    }
    
    private func increment() {
        if let intVal = Int(bindedVariable) {
            bindedVariable = String(intVal + changeValue)
        }
    }
    
    private func decrement() {
        if let intVal = Int(bindedVariable) {
            if intVal - changeValue < 0 {
               bindedVariable = "0"
            } else {
                bindedVariable = String(intVal - changeValue)
            }
        }
    }
}

public enum iPhoneModel {
  case iPhoneSE
  case iPhoneMini
  case iPhoneNormal
  case iPhoneProMax
  case unknown
  
    public static func fromScreenSize(_ screenHeight: CGFloat) -> iPhoneModel {
    switch screenHeight {
      case 667: return .iPhoneSE
      case 812: return .iPhoneMini
      case 844: return .iPhoneNormal
      case 932: return .iPhoneProMax
      default:
        return .unknown
    }
  }
   
    public static func getiPhoneModel() -> iPhoneModel {
      let screenHeight = UIScreen.main.bounds.size.height
      return Self.fromScreenSize(screenHeight)
    }
    
    public static func isIPhoneSE() -> Bool {
        self.getiPhoneModel() == iPhoneSE
    }
}

func devPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    // Set this bool to make all the prints available
    let devMode = true
    if devMode {
        for item in items {
            print(item)  // Call the standard print function
        }
    } else {}
}
