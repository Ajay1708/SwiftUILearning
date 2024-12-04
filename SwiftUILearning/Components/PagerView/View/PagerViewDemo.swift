//
//  PagerViewDemo.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 25/05/24.
//

import SwiftUI
import Kingfisher

struct PagerViewDemo: View {
    @StateObject private var viewModel = PagerDemoViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        if #available(iOS 16.0, *) {
            ZStack {
                Color(hex: "#272239").ignoresSafeArea(.all)
                
                PagerView(
                    selectedPage: $viewModel.pagerViewModel.selectedPage,
                    totalNoofPages: viewModel.pagerViewModel.totalNoofPages,
                    animationDuration: viewModel.pagerViewModel.animationDuration
                ) {
                    ForEach(Array(viewModel.stories.enumerated()), id: \.offset) { offset, story in
                        createPage(from: story)
                            .tag(offset)
                    }
                }
                .ignoresSafeArea()
                
                if viewModel.showShimmerAnimation {
                    shimmeringView
                }
            }
            .toolbar(.hidden, for: .automatic)
            .onAppear {
                viewModel.fetchStories()
            }
        } else {
            // Fallback on earlier versions
            EmptyView()
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
                        Button(action: viewModel.pagerViewModel.goToNextPage) {
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
                    goToHomeCTA
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color(hex: story.textColor))
            .padding(.horizontal, 16)
        }
    }
    
    private var goToHomeCTA: some View {
        Button(action: backAction) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color(hex: "#6038CE"))
                
                HStack {
                    Text("Go to home")
                    
                    Image(systemName: "house")
                }
                .foregroundStyle(Color.white)
            }
            .frame(height: 50)
            .font(.system(size: 14, weight: .bold))
        }
    }
    
    private var shimmeringView: some View {
        GeometryReader { reader in
            VStack(spacing: 20) {
                ForEach(1 ... 3, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(hex: "#7463A1"))
                        .frame(height: reader.size.height / 3.8)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 16)
            .redacted(reason: .placeholder)
            .shimmering()
        }
    }
    private func backAction() {
        dismiss()
    }
}

#Preview {
    PagerViewDemo()
}
