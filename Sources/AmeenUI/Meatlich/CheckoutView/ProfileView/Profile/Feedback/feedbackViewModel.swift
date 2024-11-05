//
//  feedbackViewModel.swift
//  GiveawayInsel
//
//  Created by Muhammad Ameen Khalil Qadri on 01.08.24.
//

import Foundation


class FeedbackViewModel: ObservableObject {
    @Published var title: String
    @Published var mainContent: String
    @Published var showCompletionBanner: Bool = false
   
    
    init(title: String, mainContent: String) {
        self.title = title
        self.mainContent = mainContent
    }
    init(){
        self.title = ""
        self.mainContent = ""
    }
    
    func submitFeedback(){
        if title != "" && mainContent != "" {
            
            self.showCompletionBanner.toggle()
            
          
        }
    }
}

