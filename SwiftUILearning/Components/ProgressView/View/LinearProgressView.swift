//
//  CustomProgressView.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 26/05/24.
//

import SwiftUI

/// Ref: https://sarunw.com/posts/swiftui-progressview/
struct LinearProgressView: View {
    private let progressColor: Color
    private let trackColor: Color
    private let height: CGFloat
    private let cornerRadius: CGFloat
    private let progressEnded: () -> Void
    @StateObject private var viewModel: LinearProgressViewModel
    
    /// - Parameters:
    ///   - progressColor: The color of the progress
    ///   - trackColor: The color of the track
    ///   - height: height of the progressView
    ///   - viewModel: viewmodel to handle the logic of ProgressView
    init(
        progressColor: Color,
        trackColor: Color,
        height: CGFloat,
        cornerRadius: CGFloat,
        viewModel: LinearProgressViewModel,
        progressEnded: @escaping () -> Void = {}
    ) {
        self.progressColor = progressColor
        self.trackColor = trackColor
        self.height = height
        self.cornerRadius = cornerRadius
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.progressEnded = progressEnded
    }
    
    
    var body: some View {
        ProgressView(value: viewModel.currentProgressValue)
            .progressViewStyle(CustomProgressViewStyle(
                progressColor: progressColor,
                trackColor: trackColor,
                height: height,
                cornerRadius: cornerRadius
            ))
            .progressViewStyle(.linear)
            .animation(.linear, value: viewModel.currentProgressValue)
            .onReceive(viewModel.$progressEnded, perform: { isEnded in
                if isEnded {
                    self.progressEnded()
                }
            })
    }
}

struct CustomProgressViewStyle: ProgressViewStyle {
    var progressColor: Color
    var trackColor: Color
    let height: CGFloat
    let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = CGFloat(configuration.fractionCompleted ?? 0)
        
        GeometryReader { geometry in
            let progressWidth = fractionCompleted * geometry.size.width
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(trackColor)
                
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(progressColor)
                    .frame(width: progressWidth)
            }
        }
        .frame(height: height) // Set total height of ProgressView here
    }
}


#Preview {
    let viewModel = LinearProgressViewModel(durationInSeconds: 10)
    let height: CGFloat = 15
    return LinearProgressView(
        progressColor: Color.purple,
        trackColor: Color.gray.opacity(0.5),
        height: height,
        cornerRadius: height/2,
        viewModel: viewModel
    )
}
