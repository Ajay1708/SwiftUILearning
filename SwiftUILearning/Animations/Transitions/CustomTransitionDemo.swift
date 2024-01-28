//
//  CustomTransition1.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 28/01/24.
//

import SwiftUI
struct CustomTransitionDemo: View {
    @State private var showRect = false
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            if showRect {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity)
                    .transition(.rotateOn)
            }
            Spacer()
            Button("Click") {
                withAnimation(.easeInOut) {
                    showRect.toggle()
                }
            }
            .withDefaultButtonFormatting()
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    CustomTransitionDemo()
}
