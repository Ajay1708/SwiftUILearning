//
//  ButtonComponents.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 26/01/24.
//

import Foundation
import SwiftUI

@ViewBuilder
func customButton(backgroundColor: Color = .blue, action: @escaping () -> Void) -> some View {
    Button(
        action: {
            action()
        },
        label: {
            Text("Button")
                .withDefaultButtonFormatting(backgroundColor: backgroundColor)
        }
    )
}
