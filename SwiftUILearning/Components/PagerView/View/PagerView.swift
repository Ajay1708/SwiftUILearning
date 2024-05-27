//
//  PagerView.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 23/05/24.
//

import SwiftUI

struct PagerView<Content>: View where Content: View {
    @Binding var selectedPage: Int
    private let totalNoofPages: Int
    private let animationDuration: CGFloat
    private let content: () -> Content
    
    /// - Parameters:
    ///   - selectedPage: Pass the selectedPage as a binding
    ///   - totalNoofPages: Represents total no of pages in a Tabview
    ///   - animationDuration: The linear animation duration of active page indicator
    ///   - content: Child views
    ///   - Note: The animation duration should be greater than 0
    init(
        selectedPage: Binding<Int>,
        totalNoofPages: Int,
        animationDuration: CGFloat,
        content: @escaping () -> Content
    ) {
        self._selectedPage = selectedPage
        self.totalNoofPages = totalNoofPages
        self.animationDuration = animationDuration
        self.content = content
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedPage) {
                content()
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            // Animation is necessary otherwise you won't see page style when there is a change in selectedPage
            .animation(.linear, value: selectedPage)
            
            // Shows the page control when the tabs are more than 1
            if totalNoofPages > 1 {
                HStack {
                    CustomPageControl(
                        totalNoofPages: totalNoofPages,
                        selectedPage: selectedPage,
                        animationDuration: animationDuration
                    )
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
        }
        .onAppear {
            // Removes left dragging for the first item and right dragging for the last item
            UIScrollView.appearance().bounces = false
        }
        .onDisappear {
            UIScrollView.appearance().bounces = true
        }
    }
}

// MARK: PREVIEWS
struct SlidingOnboardingFlow_Previews: PreviewProvider {
    static var previews: some View {
        PagerView(
            selectedPage: .constant(0),
            totalNoofPages: 4,
            animationDuration: 4,
            content: {EmptyView()}
        )
        
        PagerView(
            selectedPage: .constant(0),
            totalNoofPages: 4,
            animationDuration: 4,
            content: {EmptyView()}
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
    }
}
