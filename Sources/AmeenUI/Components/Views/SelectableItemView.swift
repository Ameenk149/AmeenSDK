//
//  SelectableItemView.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 07.12.24.
//
import SwiftUI

extension AQ.Meatlich {
    public struct SelectableItemView: View {
        let title: String
        let systemImage: String
        @Binding var buttonTitle: String
        let action: () -> Void
        
        public init(title: String, systemImage: String, buttonTitle: Binding<String>, action: @escaping () -> Void) {
            self.title = title
            self.systemImage = systemImage
            self._buttonTitle = buttonTitle
            self.action = action
        }
        public var body: some View {
            HStack {
                AQ.Components.AQSystemImage(systemImage: systemImage, width: 25, height: 25)
                    .padding(.horizontal)
                VStack (alignment: .leading) {
                    AQ.Components.AQText(
                        text: buttonTitle.isEmpty ? "Select \(title)" : "Change \(title)",
                        font: AmeenUIConfig.shared.appFont.titleBold()
                    )
                    if !buttonTitle.isEmpty {
                        AQ.Components.AQText(text: buttonTitle, font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 12))
                            .transition(.opacity)
                    }
                }
                Spacer()
                AQ.Components.Views.AQRightArrow()
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.clear) 
            .contentShape(Rectangle())
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor, lineWidth: 0.5)
            )
            .onTapGesture {
                action()
            }
        }
    }
    public struct SelectableItemViewWithDateTime: View {
        let title: String
        let systemImage: String
        @Binding var buttonTitle: String
        let action: () -> Void
        @Binding var selectedDate: Date
        @State private var select = false
        
        public init(
            title: String,
            systemImage: String,
            buttonTitle: Binding<String>,
            selectedDate: Binding<Date>,
            action: @escaping () -> Void
        ) {
            self.title = title
            self.systemImage = systemImage
            self._buttonTitle = buttonTitle
            self._selectedDate = selectedDate
            self.action = action
        }
        public var body: some View {
            HStack {
                AQ.Components.AQSystemImage(systemImage: systemImage, width: 25, height: 25)
                    .padding(.horizontal)
                VStack (alignment: .leading) {
                    AQ.Components.AQText(
                        text: buttonTitle.isEmpty ? "\(title)" : "\(title)",
                        font: AmeenUIConfig.shared.appFont.titleBold()
                    )
                }
                Spacer()
                if select {
                    HStack {
                        Group {
                            CustomDatePickerView(selectedDate: $selectedDate)
                            CustomTimePickerView(selectedTime: $selectedDate)
//                            DatePicker(
//                                "",
//                                selection: $selectedDate,
//                                in: Date()...(Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()),
//                                displayedComponents: .date
//                            )
//                            .onTapGesture(count: 99, perform: {})
//                            DatePicker(
//                                "",
//                                selection: $selectedDate,
//                                displayedComponents: .hourAndMinute
//                            )
                            
                        }
                        .accentColor(.green)
                        .labelsHidden()
                        .preferredColorScheme(.dark)
                        .cornerRadius(10)
                    }
                }
               else {
                    Spacer()
                    AQ.Components.Views.AQRightArrow()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.clear)
            .contentShape(Rectangle())
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor, lineWidth: 0.5)
            )
            .onTapGesture {
                if select == false {
                    withAnimation {
                        select = true
                    }
                }
            }
        }
        struct CustomTimePickerView: View {
            @Binding var selectedTime: Date
            private let calendar = Calendar.current

            var body: some View {
                Menu {
                    ForEach(availableTimes, id: \.self) { time in
                        Button {
                            selectedTime = time
                        } label: {
                            Text(timeString(from: time))
                        }
                    }
                } label: {
                    HStack {
                        AQ.Components.AQText(text: timeString(from: selectedTime), font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 12))
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                }
            }

            // Generate available times, excluding specific hours
            private var availableTimes: [Date] {
                var times: [Date] = []
                let startOfDay = calendar.startOfDay(for: Date())
                
                // Generate times from 13:00 to 19:00 with 30-minute intervals
                for hour in 13..<20 {  // 13:00 to 19:00 (exclusive of 20:00)
                    for minute in stride(from: 0, to: 60, by: 30) {
                        if let time = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: startOfDay) {
                            times.append(time)
                        }
                    }
                }
                return times
            }

            // Helper to format time for display
            private func timeString(from date: Date) -> String {
                let formatter = DateFormatter()
                formatter.timeStyle = .short
                return formatter.string(from: date)
            }
        }
        struct CustomDatePickerView: View {
            @Binding var selectedDate: Date
            private let calendar = Calendar.current
            private let dateRange = Date()...(Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date())

            var body: some View {
                VStack {
                     Menu {
                        ForEach(availableDates, id: \.self) { date in
                            Button {
                                selectedDate = date
                            } label: {
                                Text(dateString(from: date))
                            }
                        }
                    } label: {
                        HStack {
                            AQ.Components.AQText(text: dateString(from: selectedDate), font: AmeenUIConfig.shared.appFont.boldCustom(fontSize: 12))
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }

                    
                }
               
            }

            // Generate available dates excluding Tuesdays
            private var availableDates: [Date] {
                var dates: [Date] = []
                var currentDate = dateRange.lowerBound
                let endDate = dateRange.upperBound

                while currentDate <= endDate {
                    let weekday = calendar.component(.weekday, from: currentDate)
                    if weekday != 3 { // Exclude Tuesdays (3 = Tuesday in the Gregorian calendar)
                        dates.append(currentDate)
                    }
                    currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
                }

                return dates
            }

            // Helper to format the date for display
            private func dateString(from date: Date) -> String {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM"
                return formatter.string(from: date)
            }
        }
    }
    public struct ExpandableSectionView <Content: View>: View {
        let title: String
        let systemImage: String
        let content: () -> Content
       
        @State private var isExpanded: Bool = false
        
        public init(title: String, systemImage: String, @ViewBuilder content: @escaping () -> Content) {
            self.title = title
            self.systemImage = systemImage
            self.content = content
        }
        
        public var body: some View {
            VStack {
                HStack {
                    AQ.Components.AQSystemImage(systemImage: systemImage, width: 25, height: 25)
                      
                    VStack(alignment: .leading) {
                        AQ.Components.AQText(
                            text: title,
                            font: AmeenUIConfig.shared.appFont.titleBold()
                        )
                    }
                    Spacer()
                    
                    if isExpanded {
                        AQ.Components.AQSystemImage(systemImage: "chevron.down" , width: 15, height: 10)
                    } else {
                        AQ.Components.AQSystemImage(systemImage: "chevron.right", width: 10, height: 15)
                    }
                }
                .padding()
                
                
                if isExpanded {
                    VStack(alignment: .leading) {
                        content()
                    }
                    .padding(.horizontal)
                    .transition(.opacity)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor, lineWidth: 0.5)
            )
        }
    }
    
    public struct ExpandableSectionViewWithTwoButtons <Content: View>: View {
        let title: String
        let systemImage: String
        let content: () -> Content
        let button1Icon: String
        let button2Icon: String
        let button1Action: ()->Void
        let button2Action: ()->Void
        
        @State private var isExpanded: Bool
        @State private var isHighlighted: Bool
        
        public init(title: String, systemImage: String, isExpanded: Bool = false, isHighlighed: Bool = false, button1Icon: String, button2Icon: String, button1Action: @escaping () -> Void, button2Action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
            self.title = title
            self.systemImage = systemImage
            self.content = content
            self.button1Icon = button1Icon
            self.button2Icon = button2Icon
            self.button1Action = button1Action
            self.button2Action = button2Action
            self.isExpanded = isExpanded
            self.isHighlighted = isHighlighed
            
            if isHighlighed {
                self.isExpanded = true
            }
          
        }
        public var body: some View {
            VStack(spacing: 0) {
                Button {
                    withAnimation {
                        isExpanded.toggle()
                    }
                } label: {
                    HStack {
                        AQ.Components.AQSystemImage(systemImage: systemImage, width: 25, height: 25)
                        AQ.Components.AQText(
                                text: title,
                                font: AmeenUIConfig.shared.appFont.titleBold()
                            )
                        Spacer()
                        AQ.Components.AQImageButton(systemImage: button1Icon, action: button1Action)
                        AQ.Components.AQImageButton(systemImage: button2Icon, backgroundColor: .red, action: button2Action)
                        if isExpanded {
                            AQ.Components.AQSystemImage(systemImage: "chevron.down" , width: 15, height: 10)
                        } else {
                            AQ.Components.AQSystemImage(systemImage: "chevron.right", width: 10, height: 15)
                        }
                    }
                }
                .padding()
               
                
                if isExpanded {
                    content()
                    .padding(.horizontal)
                    .transition(.opacity)
                }
            }
            
            
            .background(backgroundView(isHighlighted: isHighlighted))
        }
        
        @ViewBuilder
        private func backgroundView(isHighlighted: Bool) -> some View {
            if isHighlighted {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.black)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor, lineWidth: 0.5)
            }
        }
    }
    

    
    public struct ItemView: View {
        let title: String
        let systemImage: String
        let action: () -> Void
        
        public init(title: String, systemImage: String, action: @escaping () -> Void) {
            self.title = title
            self.systemImage = systemImage
            self.action = action
        }
        
        public var body: some View {
            HStack {
                AQ.Components.AQSystemImage(systemImage: systemImage, width: 25, height: 25)
                    .padding(.horizontal)
                VStack (alignment: .leading) {
                    AQ.Components.AQText(
                        text: title,
                        font: AmeenUIConfig.shared.appFont.titleBold()
                    )
                }
                Spacer()
                AQ.Components.AQSystemImage(systemImage: "chevron.right", width: 10, height: 15)
                
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AmeenUIConfig.shared.colorPalette.buttonPrimaryColor, lineWidth: 0.5)
            )
            .onTapGesture {
                action()
            }
        }
    }
}
