//
//  PagerView.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 23/05/24.
//

import SwiftUI

struct PagerView<Content>: View where Content: View {
    @Binding var selectedPage: Int
    private let pagesCount: Int
    private let content: () -> Content
    
    init(
        selectedPage: Binding<Int>,
        pagesCount: Int,
        content: @escaping () -> Content
    ) {
        self._selectedPage = selectedPage
        self.pagesCount = pagesCount
        self.content = content
    }
    var body: some View {
        ZStack {
            TabView(selection: $selectedPage) {
                content()
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.linear, value: selectedPage)
            
            HStack {
                CustomPageControl(
                    noofPages: pagesCount,
                    selectedPage: selectedPage
                )
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea()
    }
}

// MARK: PREVIEWS
struct SlidingOnboardingFlow_Previews: PreviewProvider {
    static var previews: some View {
        PagerView(
            selectedPage: .constant(0),
            pagesCount: 4,
            content: {EmptyView()}
        )
        
        PagerView(
            selectedPage: .constant(0),
            pagesCount: 4,
            content: {EmptyView()}
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
    }
}
