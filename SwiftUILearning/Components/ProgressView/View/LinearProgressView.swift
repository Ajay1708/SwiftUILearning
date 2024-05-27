//
//  CustomProgressView.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 26/05/24.
//

import SwiftUI
/// Ref: https://sarunw.com/posts/swiftui-progressview/
struct LinearProgressView: View {
    let progressColor: Color
    let trackColor: Color
    let height: CGFloat
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
    
    
    var body: some View {
        ProgressView(value: viewModel.currentProgressValue)
            .progressViewStyle(CustomProgressViewStyle(
                height: height,
                trackColor: trackColor,
                progressColor: progressColor
            ))
            .progressViewStyle(.linear)
            .onAppear {
                viewModel.initiateTimer()
            }
    }
}

struct CustomProgressViewStyle: ProgressViewStyle {
    let height: CGFloat
    var trackColor: Color
    var progressColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = CGFloat(configuration.fractionCompleted ?? 0)
        
        GeometryReader { geometry in
            let progressWidth = fractionCompleted * geometry.size.width
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height/2)
                    .fill(trackColor)
                
                RoundedRectangle(cornerRadius: height/2)
                    .fill(progressColor)
                    .frame(width: progressWidth)
            }
        }
        .frame(height: height) // Set total height of ProgressView here
    }
}


#Preview {
    let viewModel = LinearProgressViewModel(durationInSeconds: 10)
    return LinearProgressView(
        progressColor: Color.purple,
        trackColor: Color.gray.opacity(0.5),
        height: 15,
        viewModel: viewModel
    )
}
