//
//  feedbackView.swift
//  GiveawayInsel
//
//  Created by Muhammad Ameen Khalil Qadri on 01.08.24.
//

import SwiftUI

struct FeedbackView: View {

    @StateObject var viewModel = FeedbackViewModel()
 
    var body: some View {
        ZStack {
            VStack {
                Text("Provide feedback")
                    .foregroundStyle(.white)
                    .font(Fonts.Bold.returnFont(sizeType: .title))
                    .padding()
                
                if !viewModel.showCompletionBanner {
                    showFeedbackTextFields
                        .transition(.opacity)
                } else {
                    showSuccessBanner
                        .transition(.opacity)
                }
                
            }
            .animation(.easeInOut(duration: 0.5), value: viewModel.showCompletionBanner)
            .padding()
        }
        .background(Theme.grey)
    }
    
    private var showFeedbackTextFields: some View {
        VStack {
            TextField("", text: $viewModel.title)
                .foregroundStyle(Theme.whiteColor)
                .font(Fonts.Bold.returnFont(sizeType: .title))
                .placeholder(when: viewModel.title.isEmpty) {
                    Text("Title")
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(.gray)
                        .opacity(0.35)
                        .font(Fonts.Bold.returnFont(sizeType: .title))
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: Theme.baseRadius)
                        .foregroundStyle(Theme.textFieldGrey)
                    
                }
            
            TextEditor(text: $viewModel.mainContent)
                .scrollContentBackground(.hidden)
                .foregroundStyle(Theme.whiteColor)
                .font(Fonts.Bold.returnFont(sizeType: .title))
                .lineLimit(10)
                .padding()
                .background   (
                    RoundedRectangle(cornerRadius: Theme.baseRadius)
                        .foregroundColor(Theme.textFieldGrey)
                )
                .frame(minHeight: 50)  // Set a minimum height
                .overlay(
                    Group {
                        if viewModel.mainContent.isEmpty {
                            Text("Your feedback")
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(.gray)
                                .opacity(0.35)
                                .font(Fonts.Bold.returnFont(sizeType: .title))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 27)
                        }
                    }, alignment: .topLeading
                )
            
            
            Spacer()
            
            Button(action: {
                viewModel.submitFeedback()
            }, label: {
                Text("Submit feedback")
                    .font(Fonts.regularButtonFont())
                    .foregroundStyle(Theme.whiteColor)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: Theme.baseRadius)
                            .foregroundStyle(.black)
                    }
            })
        }
    }
    
    private var showSuccessBanner: some View {
        VStack {
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(Theme.greenTextColor)
                .padding()
                
            Text("Thank you")
                .font(Fonts.Bold.returnFont(sizeType: .title))
                .frame(maxWidth: .infinity)
                .foregroundStyle(Theme.whiteColor)
               
           Text("Your feedback has been submitted")
                .font(Fonts.Medium.returnFont(sizeType: .subtitle))
                .frame(maxWidth: .infinity)
                .foregroundStyle(Theme.whiteColor.opacity(0.8))
               
            Spacer()
        }.padding()
    }
    
}



#Preview {
    FeedbackView()
}
