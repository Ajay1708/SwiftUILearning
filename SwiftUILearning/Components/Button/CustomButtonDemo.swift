//
//  CustomButtonBootCamp.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 27/01/24.
//

import SwiftUI

struct CustomButtonDemo: View {
    var body: some View {
        VStack(spacing: 20) {
            customButton(text: "Blue", action: {
                
            })
            
            customButton(text: "Red", backgroundColor: .red, action: {
                
            })
        }
        .padding()
    }
}

#Preview {
    CustomButtonDemo()
}

// MARK: - VIEW BUILDERS
@ViewBuilder
func customButton(text: String, backgroundColor: Color = .blue, action: @escaping () -> Void) -> some View {
    Button(
        action: {
            action()
        },
        label: {
            Text(text)
                .withDefaultButtonFormatting(backgroundColor: backgroundColor)
        }
    )
}
