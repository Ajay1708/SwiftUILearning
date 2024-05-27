//
//  PagerViewDemo.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 25/05/24.
//

import SwiftUI
import Kingfisher

struct PagerViewDemo: View {
    @StateObject private var viewModel = PagerViewModel()
    
    var body: some View {
        PagerView(
            selectedPage: $viewModel.selectedPage,
            totalNoofPages: viewModel.totalNoofPages,
            animationDuration: viewModel.animationDuration
        ) {
            ForEach(Array(viewModel.stories.enumerated()), id: \.offset) { offset, story in
                createPage(from: story)
                    .tag(offset)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    @ViewBuilder
    private func createPage(from story: Story) -> some View {
        ZStack {
            let imageUrl = URL(string: story.bgImge)
            KFImage(imageUrl)
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Image(.jarIcon)
                    
                    Spacer()
                    
                    if story != viewModel.lastStory {
                        Button(action: viewModel.goToNextPage) {
                            Image(systemName: "arrow.right.circle")
                                .font(.system(size: 40))
                                .foregroundStyle(Color(hex: story.textColor))
                        }
                    }
                }
                
                Text(story.title)
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                
                Text(story.description)
                    .font(.system(size: 16))
                
                Spacer()
                
                // Don't use index check because selectedPage will change when the page is half way to the next screen
                if story == viewModel.lastStory {
                    startNowCTA
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color(hex: story.textColor))
            .padding(.horizontal, 16)
        }
    }
    
    private var startNowCTA: some View {
        Button(action: startNow) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color(hex: "#6038CE"))
                
                HStack {
                    Text("Start Now")
                    
                    Image(systemName: "arrow.forward")
                }
                .foregroundStyle(Color.white)
            }
            .frame(height: 50)
            .font(.system(size: 14, weight: .bold))
        }
    }
    
    private func startNow() {}
}

#Preview {
    PagerViewDemo()
}
