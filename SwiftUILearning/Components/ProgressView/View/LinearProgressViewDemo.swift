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
    private let cornerRadius: CGFloat
    @StateObject var viewModel = LinearProgressDemoViewModel(linearProgressViewModel: LinearProgressViewModel(durationInSeconds: 30, reverse: true))
    init(
        progressColor: Color,
        trackColor: Color,
        height: CGFloat,
        cornerRadius: CGFloat
    ) {
        self.progressColor = progressColor
        self.trackColor = trackColor
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex:"#272239").ignoresSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    LinearProgressView(
                        progressColor: progressColor,
                        trackColor: trackColor,
                        height: height,
                        cornerRadius: cornerRadius,
                        viewModel: viewModel.linearProgressViewModel,
                        progressEnded: {
                            viewModel.requestGoldPriceValidity()
                        }
                    )
                    .overlay {
                        contentView
                    }
                    .opacity(viewModel.linearProgressViewModel.showShimmer ? 0 : 1)
                    .overlay {
                        if viewModel.linearProgressViewModel.showShimmer {
                            shimmerView
                        }
                    }
                    
                    Spacer()
                    
                    goToPagerViewCTA
                }
            }
            .onAppear {
                viewModel.startTimer()
            }
            .onDisappear {
                viewModel.stopTimer()
            }
        }
    }
    
    private var contentView: some View {
        HStack {
            ZStack {
                Capsule()
                    .fill(trackColor)
                    .frame(width: 50, height: 20)
                
                HStack {
                    Circle()
                        .fill(Color.pink)
                        .frame(width: 8, height: 8)
                    
                    Text("LIVE")
                        .foregroundStyle(Color.pink)
                }
                .font(.system(size: 10))
            }
            
            Group {
                Text("Buy Price: ₹7,495.71/gm")
                
                Spacer()
                
                Text("Valid For: \(viewModel.linearProgressViewModel.progressCompletionTime)")
            }
            .font(.system(size: 12))
            .foregroundStyle(Color.white)
        }
        .padding(.horizontal, 16)
    }
    
    private var shimmerView: some View {
        ZStack {
            Rectangle()
                .fill(Color.white.opacity(0.5))
                .frame(height: height)
                .redacted(reason: .placeholder)
                .shimmering()
            
            Text("Fetching New Gold Price")
                .foregroundStyle(Color.white)
                .font(.system(size: 12))
        }
    }
    
    private var goToPagerViewCTA: some View {
        NavigationLink(destination: PagerViewDemo()) {
            Text("Go to PagerView")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

// MARK: PREVIEWS
struct LinearProgressViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            
            LinearProgressViewDemo(
                progressColor: Color(hex: "#EF8A8A"),
                trackColor: Color(hex: "#3C3357"),
                height: 35,
                cornerRadius: 0
            )
        }
    }
}
