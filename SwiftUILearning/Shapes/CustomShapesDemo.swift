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
                SolidLine(color: Color.black)
                DashedLine(
                    lineLength: 5,
                    color: Color.black
                )
                SolidDivider(height: 1)
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
                SolidPentagon(width: 100, height: 100, color: .red)
            }
            HStack {
                PacMan()
                    .frame(width: 100, height: 100)
                
                SolidHalfCapsule(width: 100, height: 100, color: Color.green)
            }
            Spacer()
        }
    }
}
#Preview {
    CustomShapesDemo()
}

// MARK: - LINE
struct SolidLine: View {
    let color: Color
    var body: some View {
        Line()
            .stroke(color, lineWidth: 1)
            .frame(maxWidth: .infinity)
            .frame(height: 1)
    }
}

/// Use `SolidDivider` if you want to give desired height otherwise use `SolidLine` if you want to give height = 1
struct SolidDivider: View {
    let height: CGFloat
    var body: some View {
         Divider()
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .background(.green)
    }
}
struct DashedLine: View {
    let lineLength: CGFloat
    let color: Color
    var body: some View {
        Line()
            .stroke(color, style: StrokeStyle(lineWidth: 1, dash: [lineLength]))
            .frame(height: 1)
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
            .padding(.horizontal, -(width * 0.2))
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
            .padding(.horizontal, -(width * 0.2))
    }
}

struct SolidPentagon: View {
    let width: CGFloat
    let height: CGFloat
    let color: Color
    var body: some View {
        Pentagon()
            .fill(color)
            .frame(width: width, height: height)
            .rotationEffect(Angle(degrees: 180))

    }
}

struct SolidHalfCapsule: View {
    let width: CGFloat
    let height: CGFloat
    let color: Color
    var body: some View {
        HalfCapsule()
            .fill(color)
            .frame(width: width, height: height)
            .rotationEffect(Angle(degrees: 90))

    }
}
