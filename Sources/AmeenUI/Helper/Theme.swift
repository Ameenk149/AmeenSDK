//
//  File.swift
//  GiveawayInsel
//
//  Created by Muhammad Ameen Qadri on 07.05.23.
//

import Foundation
import SwiftUI


@available(iOS 16.0, *)
public struct Theme {
  //#colorLiteral(red: 1, green: 0.7919999957, blue: 0.1570000052, alpha: 1)
   
    /// Light greyish color
   
    static var greyColor       = Color(hue: 1.0, saturation: 0.0, brightness: 0.822)
    
    static var whiteColor      = Color.white
    static var greenTextColor = AmeenUIConfig.shared.colorPalette.buttonPrimaryColor
    public static var backgroundGradientColor = LinearGradient(colors: [.init(red: 0, green: 0, blue: 0), .init(red: 0.106, green: 0.138, blue: 0.095) ],
                                              startPoint:  .init(x: 0.5, y: 0.25),
                                                endPoint:  .init(x: 0.5, y: 0.75))
   // static var errorColor   = Color (hex: "510000")
    static var errorColor   = Color.red
    
    static var warningColor = Color.yellow.opacity(0.7)
    
    static var baseRadius: CGFloat = 10
    static var smallRadius: CGFloat = 5
    static var buttonRadius: CGFloat = 10
  
    /// Darker Shade
    static var grey = Color("Grey")
    static var mainTheme = Color("Green")
    static var textFieldGrey = Color("DarkGrey")
  
   
    struct dropShadow: ViewModifier {
        var cornerRadius: CGFloat = Theme.baseRadius
        func body(content: Content) -> some View {
            content
                .shadow(color: Color.black.opacity(0.3), radius: cornerRadius, x: 0, y: 5)
        }
    }
    
   }




extension String {
   
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func toInt() -> Int {
        return Int(self) ?? 0
    }
    
//    func toDate() -> Date? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
//        formatter.timeZone = TimeZone(secondsFromGMT: 0)
//        
//        return formatter.date(from: self)
//    }
    func toDate(format: Date.DateFormat = .other) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return formatter.date(from: self)
    }
    
    /// Removes occurrences of substrings specified in the provided array.
    ///
    /// - Parameter substrings: An array of substrings to remove from the string.
    /// - Returns: A new string with specified substrings removed.
    func removingOccurrences(of substrings: [String]) -> Self {
        var modifiedString = self
        for substring in substrings {
            modifiedString = modifiedString.replacingOccurrences(of: substring, with: "")
        }
        return modifiedString
    }
    
    func initials(limit: Int = 2) -> String {
           let words = self.split(separator: " ").filter { !$0.isEmpty }
           let limitedWords = words.prefix(limit)
           let initials = limitedWords.compactMap { $0.first }
           return String(initials)
       }
    
    func splitDateTime() -> (date: String, time: String)? {
        let components = self.split(separator: " ")
        guard components.count == 2 else {
            return nil
        }
        
        // Reconstruct the date part
        let datePart = components[0]
        let timePart = String(components[1])
        
        return (date: String(datePart), time: timePart)
    }
    
}

extension Date {
    enum DateFormat: String {
       
        /// e.g "21. Aug 2024 at 13:18"
        case postingDate = "dd. MMM yyyy 'at' HH:mm"
        case other = "yyyy-MM-dd HH:mm:ss Z"
        case dateMonthYearShort = "dd-MM-yy"
        case otherWithoutZone = "yyyy-MM-dd HH:mm:ss"
    }
    
    func toString(format: DateFormat = .otherWithoutZone) -> String? {
           let formatter = DateFormatter()
           formatter.dateFormat = format.rawValue
           return formatter.string(from: self)
       }
}

public extension Color {
    init(hex: String, opacity: CGFloat = 1) {
        var hexValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&hexValue)

        let red = Double((hexValue & 0xFF0000) >> 16) / 255.0
        let green = Double((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(hexValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, opacity: opacity)
    }
}

@available(iOS 16.0, *)
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .tint(.white)
        .navigationViewStyle(.stack)
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}


@available(iOS 16.0, *)
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

