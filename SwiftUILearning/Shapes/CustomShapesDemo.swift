//
//  PredefinedShapesDemo.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 29/01/24.
//

import SwiftUI

struct CustomShapesDemo: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            HStack {
                PlainLine(height: 1, lineWidth: 1, color: Color.black)
                DashedLine(height: 1, lineWidth: 1, lineLength: 5, color: Color.black)
            }
            HStack {
                Image(.profileIcon)
                    .resizable()
                    .clipShape(Triangle())
                    .frame(width: 100, height: 100)
                SolidTriangle(width: 100, height: 100, color: Color.brown)
                    .rotationEffect(.degrees(180))
                DashedTriangle(width: 100, height: 100, dashLength: 5, lineWidth: 1, color: Color.brown)
                
            }
            HStack {
                SolidDiamond(width: 100, height: 100, color: .red)
                DashedDiamond(width: 100, height: 100, lineWidth: 1, dashLength: 5, color: .red)
            }
            Spacer()
        }
    }
}
#Preview {
    CustomShapesDemo()
}

// MARK: - LINE
struct PlainLine: View {
    let height: CGFloat
    let lineWidth: CGFloat
    let color: Color
    var body: some View {
        Line()
            .stroke(color, lineWidth: lineWidth)
            .frame(height: height)
            .frame(maxWidth: .infinity)
    }
}
struct DashedLine: View {
    let height: CGFloat
    let lineWidth: CGFloat
    let lineLength: CGFloat
    let color: Color
    var body: some View {
        Line()
            .stroke(color, style: StrokeStyle(lineWidth: lineWidth, dash: [lineLength]))
            .frame(height: height)
            .frame(maxWidth: .infinity)
    }
}

// MARK: - TRIANGLE
struct SolidTriangle: View {
    let width: CGFloat
    let height: CGFloat
    let color: Color
    var body: some View {
        Triangle()
            .fill(color)
            .frame(width: width, height: height)
    }
}
struct DashedTriangle: View {
    let width: CGFloat
    let height: CGFloat
    let dashLength: CGFloat
    let lineWidth: CGFloat
    let color: Color
    var body: some View {
         Triangle()
            .stroke(color, style: .init(lineWidth: lineWidth, lineCap: .round, dash: [dashLength]))
            .frame(width: width, height: height)
    }
}

// MARK: - DIAMOND
struct SolidDiamond: View {
    let width: CGFloat
    let height: CGFloat
    let color: Color
    var body: some View {
        Diamond()
            .fill(color)
            .frame(width: width, height: height)
    }
}
struct DashedDiamond: View {
    let width: CGFloat
    let height: CGFloat
    let lineWidth: CGFloat
    let dashLength: CGFloat
    let color: Color
    var body: some View {
        Diamond()
            .stroke(color, style: .init(lineWidth: lineWidth, dash: [dashLength]))
            .frame(width: width, height: height)
    }
}
