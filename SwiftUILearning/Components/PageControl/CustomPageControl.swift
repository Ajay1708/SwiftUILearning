//
//  CustomPageControl.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 24/05/24.
//

import SwiftUI

struct CustomPageControl: View {
    private let totalNoofPages: Int
    private let selectedPage: Int
    private let circleDiameter: CGFloat
    private let activePageColor: Color
    private let inactivePageColor: Color
    private let spacing: CGFloat
    private let animationDuration: CGFloat
    private let backgroundColor: Color
    private let outsidePadding: CGFloat = 5
    private let initialProgressValue = 0.25
    
    /// - Parameters:
    ///   - totalNoofPages: Represents total no of pages in a Tabview
    ///   - selectedPage: Selected page from a list of pages in a Tabview
    ///   - circleDiameter: The diameter of a page indicator
    ///   - activePageColor: The color of an active page indicator
    ///   - inactivePageColor: The color of an inactive page indicator
    ///   - spacing: The spacing between page indicators
    ///   - animationDuration: The linear animation duration of active page indicator
    ///   - backgroundColor: The background color of a CustomPageControl
    init(
        totalNoofPages: Int,
        selectedPage: Int,
        circleDiameter: CGFloat = 8,
        activePageColor: Color = Color.white,
        inactivePageColor: Color = Color.gray,
        spacing: CGFloat = 8,
        animationDuration: CGFloat,
        backgroundColor: Color = Color(hex: "#4D446A")
    ) {
        self.totalNoofPages = totalNoofPages
        self.selectedPage = selectedPage
        self.circleDiameter = circleDiameter
        self.activePageColor = activePageColor
        self.inactivePageColor = inactivePageColor
        self.spacing = spacing
        self.animationDuration = animationDuration
        self.backgroundColor = backgroundColor
    }
    
    // RectangleWidth is equal to four times of circleDiameter
    var rectangleWidth: CGFloat {
        circleDiameter * 4
    }
    
    // The progress starts from 1/4 th of rectangle hence we are addition it to the total progress.
    var durationForLinearProgressView: CGFloat {
        (1 + initialProgressValue) * animationDuration
    }
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0 ..< totalNoofPages, id: \.self) { currentPage in
                if selectedPage == currentPage {
                    let viewModel = LinearProgressViewModel(
                        durationInSeconds: durationForLinearProgressView,
                        initialProgressValue: initialProgressValue
                    )
                    LinearProgressView(
                        progressColor: activePageColor,
                        trackColor: inactivePageColor,
                        height: circleDiameter,
                        cornerRadius: circleDiameter / 2,
                        viewModel: viewModel
                    )
                    .frame(width: rectangleWidth, height: circleDiameter)
                    .onAppear {
                        viewModel.startTimer()
                    }
                    .onDisappear {
                        // When user slider to new page or exists the pager view i don't want to continue the timer
                        viewModel.invalidateTimer()
                    }
                } else {
                    Circle()
                        .fill(inactivePageColor)
                        .frame(width: circleDiameter, height: circleDiameter)
                }
            }
        }
        .padding(outsidePadding)
        .background {
            RoundedRectangle(cornerRadius: circleDiameter + outsidePadding)
                .fill(backgroundColor)
        }
        .animation(.snappy, value: selectedPage)
    }
}

#Preview {
    let backgroundColor: Color = Color(hex: "#272239")
    let pageControlBgColor: Color = Color(hex: "#4D446A")
    
    return ZStack {
        Color(backgroundColor).ignoresSafeArea(.all)
        
        CustomPageControl(
            totalNoofPages: 4,
            selectedPage: 0,
            animationDuration: 4,
            backgroundColor: pageControlBgColor
        )
    }
}
