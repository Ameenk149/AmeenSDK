//
//  AQChevron.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 16.11.24.
//

import SwiftUI

extension AQ.Components.Views {
    public struct AQRightArrow: View {
        public init() {}
        public var body: some View {
                AQ.Components.AQSystemImage(systemImage: "chevron.right", width: 10, height: 15)
          }
    }
}
