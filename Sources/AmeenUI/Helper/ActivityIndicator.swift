//
//  ActivityIndicator.swift
//  GiveawayInsel
//
//  Created by Muhammad Ameen Qadri on 24.02.24.
//

import SwiftUI

final class ActivityIndicatorViewModel: ObservableObject {
    @Published var isLoading: Bool = false
}


struct ActivityIndicator: View {
    @EnvironmentObject var viewModel: ActivityIndicatorViewModel

    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
                .background(Color.black.opacity(0.5))
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 10)
        } else {
            EmptyView()
        }
    }
}
