//
//  LinearProgressViewDemo.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 26/05/24.
//

import SwiftUI

struct LinearProgressViewDemo: View {
    private let progressColor: Color
    private let trackColor: Color
    private let height: CGFloat
    @StateObject private var viewModel: LinearProgressViewModel
    
    init(
        progressColor: Color,
        trackColor: Color,
        height: CGFloat,
        viewModel: LinearProgressViewModel
    ) {
        self.progressColor = progressColor
        self.trackColor = trackColor
        self.height = height
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var progressPercentage: String {
        viewModel.currentProgressValue.formatted(.percent.precision(.fractionLength(0)))
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            VStack(alignment: .leading) {
                LinearProgressView(
                    progressColor: progressColor,
                    trackColor: trackColor,
                    height: height,
                    viewModel: viewModel
                )
                
                Text(progressPercentage)
                    .foregroundStyle(Color.gray)
            }
            .padding()
        }
    }
}

#Preview {
    LinearProgressViewDemo(
        progressColor: Color.blue,
        trackColor: Color.gray.opacity(0.5),
        height: 10,
        viewModel: LinearProgressViewModel(durationInSeconds: 10)
    )
}
