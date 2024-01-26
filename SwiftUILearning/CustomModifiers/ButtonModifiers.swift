//
//  ButtonModifiers.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 26/01/24.
//

import Foundation
import SwiftUI
struct DefaultButtonViewModifier: ViewModifier {
    let font: Font? = .headline
    let backgroundColor: Color
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 10)
    }
}

