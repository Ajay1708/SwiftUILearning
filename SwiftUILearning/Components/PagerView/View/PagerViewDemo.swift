//
//  PagerViewDemo.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 25/05/24.
//

import SwiftUI
import Kingfisher

struct PagerViewDemo: View {
    private let stories: [Story] = jarStories
    @State private var timer = Timer.publish(every: 4, on: .main, in: .default).autoconnect()
    @State private var selectedPage: Int = 0
    
    var isLastPage: Bool {
        selectedPage == stories.count - 1
    }
    
    var body: some View {
        PagerView(
            selectedPage: $selectedPage,
            pagesCount: stories.count
        ) {
            ForEach(Array(stories.enumerated()), id: \.offset) { offset, story in
                createPage(from: story)
            }
        }
        .onChange(of: selectedPage) {
            restartTimer()
        }
        .onReceive(timer, perform: { _ in
            goToNextPage()
        })
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
                    
                    if !isLastPage {
                        Button(action: goToNextPage) {
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
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color(hex: story.textColor))
            .padding(.horizontal, 16)
        }
    }
    
    private func goToNextPage() {
        selectedPage = isLastPage ? selectedPage : selectedPage + 1
    }
    
    private func restartTimer() {
        withAnimation(.linear) {
            timer.upstream.connect().cancel()
            
            if !isLastPage {
                self.timer = Timer.publish(every: 4, on: .main, in: .default).autoconnect()
            }
        }
    }
}

#Preview {
    PagerViewDemo()
}
